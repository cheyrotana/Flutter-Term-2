import 'package:week_9/data/repositories/artists/artist_repository.dart';
import 'package:week_9/model/artists/artist.dart';

class ArtistRepositoryMock implements ArtistRepository {
  final List<Artist> _artists = [];

  @override
  Future<List<Artist>> fetchArtists() {
    return Future.delayed(Duration(seconds: 4), () {
      throw Exception('Hi this is artist mock.');
    });
  }

  @override
  Future<Artist> fetchArtistById(String id) {
    return Future.delayed(Duration(seconds: 4), () {
      return _artists.firstWhere(
        (a) => a.id == id,
        orElse: () => throw Exception('No artist with id $id in the database.'),
      );
    });
  }
}
