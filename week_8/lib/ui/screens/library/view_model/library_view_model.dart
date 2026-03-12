import 'package:flutter/material.dart';
import 'package:week_7/ui/utils/async_value.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  AsyncValue<List<Song>> _songsState = const AsyncValue.loading();
  AsyncValue<List<Song>> get songsState => _songsState;

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    // 1 - Fetch songs
    _songsState = const AsyncValue.loading();
    notifyListeners();

    try {
      final songs = await songRepository.fetchSongs();
      _songsState = AsyncValue.success(songs);
    } catch (e) {
      _songsState = AsyncValue.error(e);
    }

    // 2 - notify listeners
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
