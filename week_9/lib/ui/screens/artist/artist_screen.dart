import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:week_9/data/repositories/artists/artist_repository.dart';
import 'package:week_9/ui/screens/artist/view_model/artist_view_model.dart';
import 'package:week_9/ui/screens/artist/widget/artist_content.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ArtistViewModel(artistRepository: context.read<ArtistRepository>()),
      child: Builder(
        builder: (context) {
          final ArtistViewModel av = context.watch<ArtistViewModel>();
          return ArtistContent(av: av,);
        },
      ),
    );
  }
}
