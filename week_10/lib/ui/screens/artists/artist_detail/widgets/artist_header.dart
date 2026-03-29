import 'package:flutter/material.dart';
import 'package:week_9/model/artist/artist.dart';
import 'package:week_9/ui/theme/theme.dart';

class ArtistHeader extends StatelessWidget {
  final Artist artist;

  const ArtistHeader({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              artist.imageUrl.toString(),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(artist.name, style: AppTextStyles.heading),
          Text(
            artist.genre,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
