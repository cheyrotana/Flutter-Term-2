import 'package:flutter/material.dart';
import 'package:week_9/model/comments/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          'A',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
      title: Text(
        'Ra-Fat',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.timestamp.toLocal().toString().substring(0, 16),
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 4),
          Text(comment.text, style: TextStyle(fontSize: 14)),
        ],
      ),
      isThreeLine: true,
    );
  }
}
