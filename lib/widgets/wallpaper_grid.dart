import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class WallpaperGrid extends StatelessWidget {
  const WallpaperGrid({super.key});

  final List<String> _wallpapers = const [
    'https://picsum.photos/seed/w1/400/600',
    'https://picsum.photos/seed/w2/400/600',
    'https://picsum.photos/seed/w3/400/600',
    'https://picsum.photos/seed/w4/400/600',
    'https://picsum.photos/seed/w5/400/600',
    'https://picsum.photos/seed/w6/400/600',
    'https://picsum.photos/seed/w7/400/600',
    'https://picsum.photos/seed/w8/400/600',
    // add more if you want
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(32),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.66,
      ),
      itemCount: _wallpapers.length,
      itemBuilder: (context, i) => _WallpaperCard(imageUrl: _wallpapers[i]),
    );
  }
}

class _WallpaperCard extends StatelessWidget {
  final String imageUrl;
  const _WallpaperCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/detail', arguments: imageUrl),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(FeatherIcons.heart,
                color: Colors.white.withOpacity(0.8), size: 20),
          ),
        ),
      ),
    );
  }
}