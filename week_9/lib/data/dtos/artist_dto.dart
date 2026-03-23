import 'package:week_9/model/artists/artist.dart';

class ArtistDto {
  static const String idKey = 'id';
  static const String genreKey = 'genre';
  static const String imageUrlKey = 'imageUrl';
  static const String nameKey = 'name';

  static Artist fromJson(Map<String, dynamic> json, {required String id}) {
    assert(json[genreKey] is String);
    assert(json[nameKey] is String);

    return Artist(
      genre: json[genreKey],
      imageUrl: Uri.parse(json[imageUrlKey]),
      name: json[nameKey],
      id: id,
    );
  }

  static Map<String, dynamic> toJson(Artist artist) {
    return {
      idKey: artist.id,
      nameKey: artist.name,
      genreKey: artist.genre,
      imageUrlKey: artist.imageUrl.toString(),
    };
  }
}
