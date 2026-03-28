import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final String baseUrl =
      'week-10-db-default-rtdb.asia-southeast1.firebasedatabase.app';
  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = false}) async {
    if (_cachedSongs != null && !forceFetch) {
      return _cachedSongs!;
    }

    final http.Response response = await http.get(
      Uri.https(baseUrl, '/songs.json'),
    );

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      _cachedSongs = result;
      return _cachedSongs!;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    final http.Response response = await http.get(
      Uri.https(baseUrl, '/songs/$id.json'),
    );

    if (response.statusCode == 200) {
      return SongDto.fromJson(id, json.decode(response.body));
    } else {
      throw Exception('Failed to load song.');
    }
  }

  @override
  Future<Song> likeSong(String id) async {
    final Uri songByIdUri = Uri.https(baseUrl, '/songs/$id.json');
    final Song? songById = await fetchSongById(id);
    if (songById == null) {
      throw Exception('Song not found');
    }
    final int currentLike = songById.likes;

    await http.patch(
      songByIdUri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({SongDto.likesKey: currentLike + 1}),
    );

    final Song? updatedSong = await fetchSongById(id);
    if (updatedSong == null) {
      throw Exception('Song not found after liking');
    }

    if (_cachedSongs != null) {
      _cachedSongs = [
        for (final song in _cachedSongs!) song.id == id ? updatedSong : song,
      ];
    }

    return updatedSong;
  }
}
