import 'package:flutter/material.dart';
import 'package:week_7/model/songs/song.dart';
import 'package:week_7/ui/screens/home/view_model/home_view_model.dart';
import 'package:week_7/ui/theme/theme.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required this.homeViewModel});

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text('Recent Songs', style: AppTextStyles.body),
        ),
        ...homeViewModel.recentSongs.map(
          (song) => SongTile(
            song: song,
            isPlaying: homeViewModel.isPlaying(song),
            onTap: () => homeViewModel.playSong(song),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text('Recommended', style: AppTextStyles.body),
        ),
        ...homeViewModel.recommendedSongs.map(
          (song) => SongTile(
            song: song,
            isPlaying: homeViewModel.isPlaying(song),
            onTap: () => homeViewModel.playSong(song),
          ),
        ),
      ],
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: Text(
        isPlaying ? 'Playing' : '',
        style: const TextStyle(color: Colors.amber),
      ),
    );
  }
}
