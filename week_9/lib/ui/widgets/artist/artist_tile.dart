import 'package:flutter/material.dart';
import 'package:week_9/model/artists/artist.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({
    super.key,
    required this.genre,
    required this.imageUrl,
    required this.name,
    required this.artist,
  });

  final Artist artist;
  final String genre;
  final Uri imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl.toString()),
          ),
          title: Text(artist.name),
          subtitle: Text(artist.genre),
        ),
      ),
    );
  }
}
