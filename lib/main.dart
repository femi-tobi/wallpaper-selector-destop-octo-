import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/category_screen.dart';
import 'screens/browse_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/favourites_screen.dart'; // ADD THIS

void main() {
  runApp(const WallpaperStudioApp());
}

class WallpaperStudioApp extends StatelessWidget {
  const WallpaperStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/category': (context) {
          final arg = ModalRoute.of(context)!.settings.arguments;
          final category = (arg is String) ? arg : 'Nature';
          return CategoryScreen(category: category);
        },
        '/browse': (context) => const BrowseScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/favourites': (context) => const FavouritesScreen(), // ADD THIS
      },
    );
  }
}