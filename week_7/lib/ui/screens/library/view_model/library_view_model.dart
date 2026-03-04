import 'package:flutter/material.dart';
import 'package:week_7/data/repositories/songs/song_repository.dart';
import 'package:week_7/model/songs/song.dart';
import 'package:week_7/ui/states/player_state.dart';
import 'package:week_7/ui/states/settings_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository _songRepository;
  final AppSettingsState _settingsState;
  final PlayerState _playerState;

  List<Song> _songs = [];
  
  LibraryViewModel({
    required SongRepository songRepository,
    required AppSettingsState settingsState,
    required PlayerState playerState,
  })  : _songRepository = songRepository,
        _settingsState = settingsState,
        _playerState = playerState {
    _playerState.addListener(_onPlayerChanged);
  }

  void _onPlayerChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _playerState.removeListener(_onPlayerChanged);
    super.dispose();
  }


  List<Song> get songs => _songs;
  Future<void> init() async {
    _songs = _songRepository.fetchSongs();
    notifyListeners();
  }

  Song? get currentSong => _playerState.currentSong;
  Color get background => _settingsState.theme.backgroundColor;

  bool isPlaying(Song song) {
    if (currentSong?.id != song.id) return false;
    return true;
  }

  void playSong(Song song) {
    if (isPlaying(song)) {
      _playerState.stop();
    } else {
      _playerState.start(song);
    }
  }
}
