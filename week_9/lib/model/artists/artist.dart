class Artist {
  final String id;
  final String genre;
  final Uri imageUrl;
  final String name;

  Artist({
    required this.genre,
    required this.imageUrl,
    required this.name,
    required this.id,
  });

  @override
  String toString() {
    return 'Artist(id: $id, genre: $genre, imageUrl: $imageUrl, name: $name )';
  }
}
