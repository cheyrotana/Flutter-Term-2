import 'package:week_9/data/repositories/songs/song_repository_firebase.dart';
import 'package:week_9/model/songs/song.dart';

void main() async {
  //   Instantiate the  song_repository_mock
   SongRepositoryFirebase songRepository = SongRepositoryFirebase();

  List<Song> songs = await songRepository.fetchSongs();

  for (var song in songs) {
    print(song);
  }
}
