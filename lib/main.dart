import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/category_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/favorites_screen.dart';

void main() => runApp(const WallpaperApp());

class WallpaperApp extends StatelessWidget {
  const WallpaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Selector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        textTheme: GoogleFonts.interTextTheme(
          const TextTheme().apply(bodyColor: Colors.white),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/category': (_) => const CategoryScreen(),
        '/detail': (_) => const DetailScreen(),
        '/favorites': (_) => const FavoritesScreen(),
      },
    );
  }
}