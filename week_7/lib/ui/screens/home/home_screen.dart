import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_7/data/repositories/songs/song_repository.dart';
import 'package:week_7/data/repositories/user_history/user_history_repository.dart';
import 'package:week_7/ui/screens/home/view_model/home_view_model.dart';
import 'package:week_7/ui/screens/home/widgets/home_content.dart';
import 'package:week_7/ui/states/player_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _homeViewModel = HomeViewModel(
      songRepository: context.read<SongRepository>(),
      userHistoryRepository: context.read<UserHistoryRepository>(),
      playerState: context.read<PlayerState>(),
    );
    _homeViewModel.init();
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _homeViewModel,
      builder: (context, _) => HomeContent(homeViewModel: _homeViewModel),
    );
  }
}
