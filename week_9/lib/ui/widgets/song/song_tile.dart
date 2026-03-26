import 'package:flutter/material.dart';
import 'package:week_9/model/artist_song/artist_song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.artistSong,
    required this.isPlaying,
    required this.onTap,
  });

  final ArtistSong artistSong;
  final bool isPlaying;
  final VoidCallback onTap;

  String _formatDuration(Duration duration) {
    String minutes = duration.inMinutes.toString();
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              artistSong.songData.imageUrl.toString(),
            ),
          ),
          onTap: onTap,
          title: Text(artistSong.songData.title),
          subtitle: Text(
            '${_formatDuration(artistSong.songData.duration)} ${artistSong.artistData.name} ${artistSong.artistData.genre}',
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
