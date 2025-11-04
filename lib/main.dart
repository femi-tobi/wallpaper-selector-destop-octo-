import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:window_size/window_size.dart'
    if (dart.library.html) 'package:flutter/widgets.dart';

import 'screens/home_screen.dart';
import 'screens/browse_screen.dart';
import 'screens/favourites_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/category_screen.dart';
import 'screens/browse_category_screen.dart';
import 'screens/wallpaper_setup_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!identical(0, 0.0)) {
    setWindowTitle('Wallpaper Studio');
    setWindowMinSize(const Size(1200, 800));
    setWindowMaxSize(Size.infinite);
  }

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
        '/': (c) => const HomeScreen(),
        '/browse': (c) => const BrowseScreen(),
        '/favourites': (c) => const FavouritesScreen(),
        '/settings': (c) => const SettingsScreen(),

        '/category': (c) {
          final arg = ModalRoute.of(c)!.settings.arguments as String?;
          return CategoryScreen(category: arg ?? 'Nature');
        },

        '/browse-category': (c) {
          final arg = ModalRoute.of(c)!.settings.arguments as String?;
          return BrowseCategoryScreen(category: arg ?? 'Nature');
        },

        '/wallpaper-setup': (c) {
          final args = ModalRoute.of(c)!.settings.arguments as Map<String, String>?;
          return WallpaperSetupScreen(
            wallpaperName: args?['name'] ?? 'Unknown Wallpaper',
            wallpaperPath: args?['path'] ?? 'assets/images/nature1.jpg',
          );
        },
      },
    );
  }
}