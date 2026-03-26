import 'package:flutter/material.dart';
import 'package:week_9/model/artist_song/artist_song.dart';
import 'package:week_9/services/artist_song_service.dart';
import '../../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  final ArtistSongService _artistSongService;

  AsyncValue<List<ArtistSong>> artistSongsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required ArtistSongService artistSongService,
  }) : _artistSongService = artistSongService {
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
    fetchData();
  }

  void fetchData() async {
    // 1- Loading state
    artistSongsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<ArtistSong> data = await _artistSongService.fetchArtistSong();
      artistSongsValue = AsyncValue.success(data);
    } catch (e) {
      // 3- Fetch is unsucessfull
      artistSongsValue = AsyncValue.error(e);
    }
     notifyListeners();

  }


  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
