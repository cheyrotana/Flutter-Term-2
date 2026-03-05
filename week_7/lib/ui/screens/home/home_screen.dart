import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_7/data/repositories/songs/song_repository.dart';
import 'package:week_7/data/repositories/user_history/user_history_repository.dart';
import 'package:week_7/ui/screens/home/view_model/home_view_model.dart';
import 'package:week_7/ui/screens/home/widgets/home_content.dart';
import 'package:week_7/ui/states/player_state.dart';
import 'package:week_7/ui/states/settings_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(
        songRepository: context.read<SongRepository>(),
        userHistoryRepository: context.read<UserHistoryRepository>(),
        playerState: context.read<PlayerState>(),
        settingsState: context.read<AppSettingsState>(),
      )..init(),
      child: const HomeContent(),
    );
  }
}
