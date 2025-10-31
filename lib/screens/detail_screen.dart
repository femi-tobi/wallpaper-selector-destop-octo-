import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Stack(
        children: [
          InteractiveViewer(
            child: Center(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          _TopBar(),
          _BottomActions(imageUrl: imageUrl),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 64,
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(FeatherIcons.arrowLeft, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            const Spacer(),
            IconButton(icon: const Icon(FeatherIcons.download, color: Colors.white), onPressed: () {}),
            const SizedBox(width: 16),
            IconButton(icon: const Icon(FeatherIcons.share2, color: Colors.white), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final String imageUrl;
  const _BottomActions({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 80,
        color: Colors.black.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(FeatherIcons.heart, size: 18),
              label: const Text('Add to Favorites'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C853),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(FeatherIcons.check, size: 18),
              label: const Text('Set as Wallpaper'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}