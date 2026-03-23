import 'package:flutter/material.dart';
import 'package:week_9/model/artists/artist.dart';
import 'package:week_9/ui/screens/artist/view_model/artist_view_model.dart';
import 'package:week_9/ui/theme/theme.dart';
import 'package:week_9/ui/utils/async_value.dart';
import 'package:week_9/ui/widgets/artist/artist_tile.dart';

class ArtistContent extends StatelessWidget {
  final ArtistViewModel av;

  const ArtistContent({super.key, required this.av});

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Artist>> asyncValue = av.artistValue;
    Widget content;

    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );
      case AsyncValueState.success:
        List<Artist> artists = asyncValue.data!;
        content = ListView.builder(
          itemCount: artists.length,
          itemBuilder: (context, index) => ArtistTile(
            genre: artists[index].genre,
            imageUrl: artists[index].imageUrl,
            name: artists[index].name,
            artist: artists[index],
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Artist", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}
