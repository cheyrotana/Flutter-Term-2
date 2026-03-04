import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_7/ui/screens/library/view_model/library_view_model.dart';
import 'package:week_7/ui/screens/library/widgets/library_content.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import '../../states/settings_state.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryViewModel = LibraryViewModel(
      songRepository: context.read<SongRepository>(),
      settingsState: context.read<AppSettingsState>(),
      playerState: context.watch<PlayerState>(),
    );

    return LibraryContent(libraryViewModel: libraryViewModel);
  }
}
