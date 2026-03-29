import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_9/model/songs/song.dart';
import 'package:week_9/ui/screens/artists/artist_detail/view_model/artist_detail_view_model.dart';
import 'package:week_9/ui/screens/library/view_model/library_item_data.dart';
import 'package:week_9/ui/screens/library/widgets/library_item_tile.dart';
import 'package:week_9/ui/states/player_state.dart';
import 'package:week_9/ui/utils/async_value.dart';

class SongsSection extends StatelessWidget {
  final ArtistDetailViewModel mv;

  const SongsSection({super.key, required this.mv});

  @override
  Widget build(BuildContext context) {
    switch (mv.songsValue.state) {
      case AsyncValueState.loading:
        return const Center(child: CircularProgressIndicator());
      case AsyncValueState.error:
        return Text(
          'Error: ${mv.songsValue.error}',
          style: const TextStyle(color: Colors.red),
        );
      case AsyncValueState.success:
        final List<Song> songs = mv.songsValue.data!;
        if (songs.isEmpty) {
          return const Center(child: Text('No songs for this artist'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: songs.length,
          itemBuilder: (context, index) => LibraryItemTile(
            data: LibraryItemData(song: songs[index], artist: mv.artist),
            isPlaying:
                context.watch<PlayerState>().currentSong?.id == songs[index].id,
            onTap: () => context.read<PlayerState>().start(songs[index]),
            onLike: () => mv.likeSong(songs[index].id),
          ),
        );
    }
  }
}
