import 'package:flutter/material.dart';
import 'package:week_7/ui/utils/async_value.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  List<Song>? _songs;

  AsyncValue<List<Song>> _songsState = const AsyncValue.loading();
  AsyncValue<List<Song>> get songsState => _songsState;

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  List<Song> get songs => _songs == null ? [] : _songs!;

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
      _songs = await songRepository.fetchSongs();
      _songsState = AsyncValue.success(_songs);
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
