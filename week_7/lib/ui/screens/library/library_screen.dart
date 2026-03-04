import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_7/ui/screens/library/view_model/library_view_model.dart';
import 'package:week_7/ui/screens/library/widgets/library_content.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import '../../states/settings_state.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late LibraryViewModel _libraryViewModel;

  @override
  void initState() {
    super.initState();
    _libraryViewModel = LibraryViewModel(
      songRepository: context.read<SongRepository>(),
      settingsState: context.read<AppSettingsState>(),
      playerState: context.read<PlayerState>(),
    );
    _libraryViewModel.init();
  }

  @override
  void dispose() {
    _libraryViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _libraryViewModel,
      builder: (context, _) =>
          LibraryContent(libraryViewModel: _libraryViewModel),
    );
  }
}
