import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_9/ui/screens/artists/artist_detail/view_model/artist_detail_view_model.dart';
import 'package:week_9/ui/theme/theme.dart';

import 'artist_header.dart';
import 'comment_input_bar.dart';
import 'comments_section.dart';
import 'songs_section.dart';

class ArtistDetailContent extends StatelessWidget {
  const ArtistDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtistDetailViewModel mv = context.watch<ArtistDetailViewModel>();

    return Column(
      children: [
        ArtistHeader(artist: mv.artist),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Songs', style: AppTextStyles.body),
                const SizedBox(height: 8),
                SongsSection(mv: mv),
                const SizedBox(height: 24),
                Text('Comments', style: AppTextStyles.body),
                const SizedBox(height: 8),
                CommentsSection(mv: mv),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        const CommentInputBar(),
      ],
    );
  }
}
