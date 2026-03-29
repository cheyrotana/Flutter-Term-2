import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:week_9/data/dtos/comment_dto.dart';

import '../../../model/artist/artist.dart';
import '../../../model/comments/comment.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final String baseUrl =
      'week-10-db-default-rtdb.asia-southeast1.firebasedatabase.app';

  List<Artist>? _cachedArtist;

  @override
  Future<List<Artist>> fetchArtists({bool forceFetch = false}) async {
    if (_cachedArtist != null && !forceFetch) {
      return _cachedArtist!;
    }
    final http.Response response = await http.get(
      Uri.https(baseUrl, '/artists.json'),
    );

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Artist> result = [];
      for (final entry in songJson.entries) {
        result.add(ArtistDto.fromJson(entry.key, entry.value));
      }
      _cachedArtist = result;
      return _cachedArtist!;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    final http.Response response = await http.get(
      Uri.https(baseUrl, '/artists/$id.json'),
    );

    if (response.statusCode == 200) {
      return ArtistDto.fromJson(id, json.decode(response.body));
    } else {
      throw Exception('Failed to load artist.');
    }
  }

  @override
  Future<List<Comment>> fetchArtistComments(String artistId) async {
    final http.Response response = await http.get(
      Uri.https(baseUrl, '/comments/$artistId.json'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> artistCommentsJson = json.decode(response.body);
      List<Comment> artistComments = [];
      for (final entry in artistCommentsJson.entries) {
        artistComments.add(CommentDto.fromJson(entry.key, entry.value));
      }
      return artistComments;
    } else {
      throw Exception('Failed to load comments.');
    }
  }

  @override
  Future<Comment> postComment(String artistId, String text) async {
    final Uri artistByIdUrl = Uri.https(baseUrl, '/comments/$artistId.json');

    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    final http.Response response = await http.post(
      artistByIdUrl,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        CommentDto.artistIdKey: artistId,
        CommentDto.textKey: text,
        CommentDto.timestampKey: timestamp,
      }),
    );

    final Map<String, dynamic> responseJson = json.decode(response.body);
    final generatedId = responseJson['name'];

    return Comment(
      id: generatedId,
      artistId: artistId,
      text: text,
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }
}
