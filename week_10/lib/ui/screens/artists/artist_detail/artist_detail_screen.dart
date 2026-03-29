import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_9/data/repositories/artist/artist_repository.dart';
import 'package:week_9/data/repositories/songs/song_repository.dart';
import 'package:week_9/model/artist/artist.dart';
import 'package:week_9/ui/screens/artists/artist_detail/view_model/artist_detail_view_model.dart';
import 'package:week_9/ui/screens/artists/artist_detail/widgets/artist_detail_content.dart';
import 'package:week_9/ui/states/settings_state.dart';

class ArtistDetailScreen extends StatelessWidget {
  final Artist artist;

  const ArtistDetailScreen({super.key, required this.artist});
  @override
  Widget build(BuildContext context) {
    final bg = context.watch<AppSettingsState>().theme.backgroundColor;
    return ChangeNotifierProvider(
      create: (context) => ArtistDetailViewModel(
        artistRepo: context.read<ArtistRepository>(),
        songRepo: context.read<SongRepository>(),
        artist: artist,
      ),
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(title: Text(artist.name)),
        body: ArtistDetailContent(),
      ),
    );
  }
}
