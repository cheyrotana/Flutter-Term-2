import '../data/repositories/songs/song_repository_mock.dart';

void main() async {
  // Instantiate the song_repository_mock
  final repo = SongRepositoryMock();

  print('--- Test 1: then() / catchError() ---');

  // SUCCESS — fetchSongs using then/catchError
  await repo
      .fetchSongs()
      .then((songs) {
        print('Success: fetched ${songs.length} songs');
        for (var s in songs) {
          print('  - ${s.title}');
        }
      })
      .catchError((e) {
        print('Error: $e');
      });

  // FAILURE — fetchSongById with invalid id using then/catchError
  await repo
      .fetchSongById('invalid_id')
      .then((song) {
        if (song == null) {
          print('No song found for that id.');
        } else {
          print('Found: ${song.title}');
        }
      })
      .catchError((e) {
        print('Error: $e');
      });

  print('--- Test 2: async/await with try/catch ---');

  // SUCCESS — fetchSongs using async/await
  try {
    final songs = await repo.fetchSongs();
    print('Success: fetched ${songs.length} songs');
    for (var s in songs) {
      print('  - ${s.title}');
    }
  } catch (e) {
    print('Error: $e');
  }

  // FAILURE — fetchSongById with invalid id using async/await
  try {
    final song = await repo.fetchSongById('invalid_id');
    if (song == null) {
      print('No song found for that id.');
    } else {
      print('Found: ${song.title}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
