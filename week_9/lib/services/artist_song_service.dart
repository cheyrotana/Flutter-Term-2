import 'package:week_9/data/repositories/artists/artist_repository.dart';
import 'package:week_9/data/repositories/songs/song_repository.dart';
import 'package:week_9/model/artist_song/artist_song.dart';
import 'package:week_9/model/artists/artist.dart';
import 'package:week_9/model/songs/song.dart';

class ArtistSongService {
  final ArtistRepository artistRepository;
  final SongRepository songRepository;

  ArtistSongService({
    required this.artistRepository,
    required this.songRepository,
  });

  Future<List<ArtistSong>> fetchArtistSong() async {
    final List<Artist> artists = await artistRepository.fetchArtists();
    final List<Song> songs = await songRepository.fetchSongs();
    final List<ArtistSong> artistSongs = [];

    for (Song song in songs) {
      Artist? matchedArtist;
      for (Artist artist in artists) {
        if (artist.id == song.artistId) {
          matchedArtist = artist;
          break;
        }
      }
      if (matchedArtist != null) {
        final ArtistSong artistSong = ArtistSong(
          artistData: matchedArtist,
          songData: song,
        );
        artistSongs.add(artistSong);
      }
    }
    return artistSongs;
  }
}