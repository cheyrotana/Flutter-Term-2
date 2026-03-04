import 'package:flutter/material.dart';
import 'package:week_7/data/repositories/songs/song_repository.dart';
import 'package:week_7/model/songs/song.dart';
import 'package:week_7/ui/states/player_state.dart';
import 'package:week_7/ui/states/settings_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository _songRepository;
  final AppSettingsState settingsState;
  final PlayerState playerState;

  LibraryViewModel({
    required SongRepository songRepository,
    required this.settingsState,
    required this.playerState,
  }) : _songRepository = songRepository {
    playerState.addListener(_onPlayerChanged);
  }

  void _onPlayerChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    playerState.removeListener(_onPlayerChanged);
    super.dispose();
  }

  List<Song> _songs = [];
  List<Song> get songs => _songs;
  Future<void> init() async {
    _songs = _songRepository.fetchSongs();
    notifyListeners();
  }

  Song? get currentSong => playerState.currentSong;
  Color get background => settingsState.theme.backgroundColor;

  bool isPlaying(Song song) {
    if (currentSong?.id != song.id) return false;
    return true;
  }

  void playSong(Song song) {
    if (isPlaying(song)) {
      playerState.start(song);
    }
  }

  void stopSong(Song song) {
    playerState.stop();
  }
}
