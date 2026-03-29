class Comment {
  final String id;
  final String artistId;
  final String text;
  final DateTime timestamp;

  Comment({
    required this.id,
    required this.artistId,
    required this.text,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'Comment(id: $id, artistId: $artistId, text: $text, timestamp: $timestamp)';
  }
}
