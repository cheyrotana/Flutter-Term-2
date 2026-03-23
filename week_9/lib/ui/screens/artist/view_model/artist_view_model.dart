import 'package:flutter/widgets.dart';
import 'package:week_9/data/repositories/artists/artist_repository.dart';
import 'package:week_9/model/artists/artist.dart';
import 'package:week_9/ui/utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  AsyncValue<List<Artist>> artistValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository}) {
    _init();
  }

  void _init() {
    fetchSong();
  }

  void fetchSong() async {
    artistValue = AsyncValue.loading();
    notifyListeners();
    try {
      List<Artist> artists = await artistRepository.fetchArtists();
      artistValue = AsyncValue.success(artists);
    } catch (e) {
      artistValue = AsyncValue.error(e);
    }

    notifyListeners();
  }
}
