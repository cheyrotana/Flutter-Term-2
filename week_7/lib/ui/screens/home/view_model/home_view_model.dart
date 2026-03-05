import 'package:flutter/material.dart';
import 'package:week_7/data/repositories/songs/song_repository.dart';
import 'package:week_7/data/repositories/user_history/user_history_repository.dart';
import 'package:week_7/model/songs/song.dart';
import 'package:week_7/ui/states/player_state.dart';
import 'package:week_7/ui/states/settings_state.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository _songRepository;
  final UserHistoryRepository _userHistoryRepository;
  final PlayerState _playerState;
  final AppSettingsState _settingsState;

  HomeViewModel({
    required SongRepository songRepository,
    required PlayerState playerState,
    required UserHistoryRepository userHistoryRepository,
    required AppSettingsState settingsState,
  }) : _songRepository = songRepository,
       _playerState = playerState,
       _userHistoryRepository = userHistoryRepository,
       _settingsState = settingsState {
    playerState.addListener(_onPlayerChanged);
  }
  void _onPlayerChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _playerState.removeListener(_onPlayerChanged);
    super.dispose();
  }

  List<Song> _recentSongs = [];
  List<Song> _recommendedSongs = [];

  List<Song> get recentSongs => _recentSongs;
  List<Song> get recommendedSongs => _recommendedSongs;
  Song? get currentSong => _playerState.currentSong;
  Color get background => _settingsState.theme.backgroundColor;

  void _refreshSongs() {
    final List<String> recentIds = _userHistoryRepository.fetchRecentSongIds();

    // Convert each ID to full Song object
    _recentSongs = recentIds
        .map((id) => _songRepository.fetchSongById(id))
        .whereType<Song>()
        .toList();

    // Recommended = all songs except recent
    final Set<String> recentIdsSet = recentIds.toSet();
    _recommendedSongs = _songRepository
        .fetchSongs()
        .where((song) => !recentIdsSet.contains(song.id))
        .toList();
  }

  Future<void> init() async {
    _refreshSongs();
    notifyListeners();
  }

  bool isPlaying(Song song) => currentSong?.id == song.id;

  void playSong(Song song) {
    if (isPlaying(song)) {
      _playerState.stop();
    } else {
      _playerState.start(song);
      _userHistoryRepository.addToRecent(song.id);

      // Refresh songs so the UI updates immediately
      _refreshSongs();
    }
    notifyListeners();
  }
}
