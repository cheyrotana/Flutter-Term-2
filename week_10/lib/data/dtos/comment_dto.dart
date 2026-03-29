import '../../model/comments/comment.dart';

class CommentDto {
  static const String artistIdKey = 'artistId';
  static const String textKey = 'text';
  static const String timestampKey = 'timestamp'; // in ms

  static Comment fromJson(String id, Map<String, dynamic> json) {
    assert(json[artistIdKey] is String);
    assert(json[textKey] is String);
    assert(json[timestampKey] is num);

    return Comment(
      id: id,
      artistId: json[artistIdKey],
      text: json[textKey],
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          (json[timestampKey] as num).toInt()),
    );
  }

  /// Convert Comment to JSON
  Map<String, dynamic> toJson(Comment comment) {
    return {
      artistIdKey: comment.artistId,
      textKey: comment.text,
      timestampKey: comment.timestamp.millisecondsSinceEpoch,
    };
  }
}
