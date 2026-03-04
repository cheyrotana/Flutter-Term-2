import 'package:flutter/material.dart';
import 'package:week_7/model/songs/song.dart';
import 'package:week_7/ui/screens/library/view_model/library_view_model.dart';
import 'package:week_7/ui/theme/theme.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key, required this.libraryViewModel});

  final LibraryViewModel libraryViewModel;

  @override
  Widget build(BuildContext context) {
    final songs = [...libraryViewModel.songs];
    return Container(
      color: libraryViewModel.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) => SongTile(
                song: songs[index],
                isPlaying: libraryViewModel.isPlaying(songs[index]),
                onTap: () => libraryViewModel.playSong(songs[index]),
              ),
            ),
          ),
        ],
      ),
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
        isPlaying ? "Playing" : "",
        style: TextStyle(color: Colors.amber),
      ),
    );
  }
}
