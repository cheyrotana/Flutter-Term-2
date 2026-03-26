import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_9/services/artist_song_service.dart';
import 'view_model/library_view_model.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import 'widgets/library_content.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LibraryViewModel(
        playerState: context.read<PlayerState>(),
        songRepository: context.read<SongRepository>(),
        artistSongService: context.read<ArtistSongService>(),
      ),
      child: LibraryContent(),
    );
  }
}
