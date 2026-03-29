import 'package:flutter/material.dart';
import 'package:week_9/model/comments/comment.dart';
import 'package:week_9/ui/screens/artists/artist_detail/view_model/artist_detail_view_model.dart';
import 'package:week_9/ui/screens/artists/artist_detail/widgets/comment_tile.dart';
import 'package:week_9/ui/utils/async_value.dart';

class CommentsSection extends StatelessWidget {
  final ArtistDetailViewModel mv;

  const CommentsSection({super.key, required this.mv});

  @override
  Widget build(BuildContext context) {
    switch (mv.commentsValue.state) {
      case AsyncValueState.loading:
        return const Center(child: CircularProgressIndicator());
      case AsyncValueState.error:
        return Text(
          'Error: ${mv.commentsValue.error}',
          style: const TextStyle(color: Colors.red),
        );
      case AsyncValueState.success:
        final List<Comment> comments = mv.commentsValue.data!;
        if (comments.isEmpty) {
          return const Center(child: Text('No comments yet.'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) =>
              CommentTile(comment: comments[index]),
        );
    }
  }
}
