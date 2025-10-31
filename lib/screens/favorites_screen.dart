import 'package:flutter/material.dart';
import '../widgets/wallpaper_grid.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const _Sidebar(currentRoute: '/favorites'),
          Expanded(child: _ContentArea(title: 'Favorites')),
        ],
      ),
    );
  }
}

// Reuse _Sidebar, _ContentArea, _WallpaperGrid from home_screen.dart