import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/browse_screen.dart';
import 'screens/category_screen.dart';        // <-- old one (Home)
import 'screens/browse_category_screen.dart'; // <-- NEW one (Browse)

void main() => runApp(const WallpaperStudioApp());

class WallpaperStudioApp extends StatelessWidget {
  const WallpaperStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (c) => const HomeScreen(),
        '/browse': (c) => const BrowseScreen(),

        // ── FROM HOME ──
        '/category': (c) {
          final arg = ModalRoute.of(c)!.settings.arguments as String?;
          return CategoryScreen(category: arg ?? 'Nature');
        },

        // ── FROM BROWSE ── (NEW)
        '/browse-category': (c) {
          final arg = ModalRoute.of(c)!.settings.arguments as String?;
          return BrowseCategoryScreen(category: arg ?? 'Nature');
        },

        // …other routes (settings, favourites, etc.)
      },
    );
  }
}