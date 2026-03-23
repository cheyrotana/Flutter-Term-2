import 'dart:convert';

import 'package:week_9/data/dtos/artist_dto.dart';
import 'package:week_9/data/repositories/artists/artist_repository.dart';
import 'package:week_9/model/artists/artist.dart';
import 'package:http/http.dart' as http;

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistUri = Uri.https(
    'week-9-practice-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);
      final List<Artist> artistsList = [];
      for (var entry in artistJson.entries) {
        artistsList.add(ArtistDto.fromJson(entry.value, id: entry.key));
      }
      return artistsList;
    } else {
      throw Exception('Failed to load artist.');
    }
  }

  @override
  Future<Artist> fetchArtistById(String id) async {
    final Uri artistByIdUri = Uri.https(
      'week-9-practice-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/artists/$id.json',
    );

    final http.Response response = await http.get(artistByIdUri);
    if (response.statusCode == 200) {
      final Artist artistJson = json.decode(response.body);
      return ArtistDto.fromJson(
        artistJson as Map<String, dynamic>,
        id: artistJson.id,
      );
    } else {
      throw Exception('Failed to load artist.');
    }
  }
}


    // if (response.statusCode == 200) {
    //   Map<String, dynamic> artistJson = json.decode(response.body);
    //   return ArtistDto.fromJson(artistJson, id: id);
    // } else {
    //   throw Exception('Failed to load artist.');
    // }