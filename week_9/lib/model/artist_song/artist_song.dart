import 'package:week_9/model/artists/artist.dart';
import 'package:week_9/model/songs/song.dart';

class ArtistSong {
  final Artist artistData;
  final Song songData;

  ArtistSong({required this.artistData, required this.songData});

  @override
  String toString() {
    return 'ArtistSong(artist: $artistData, song: $songData)';
  }
}
