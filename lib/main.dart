import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Conditional import – only loads window_size on desktop
import 'package:window_size/window_size.dart'
    if (dart.library.html) 'package:flutter/widgets.dart';

import 'screens/home_screen.dart';
import 'screens/browse_screen.dart';
import 'screens/favourites_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/category_screen.dart';
import 'screens/browse_category_screen.dart';

void main() {
  // --------------------------------------------------------------
  // DESKTOP-ONLY WINDOW SETUP
  // --------------------------------------------------------------
  WidgetsFlutterBinding.ensureInitialized();

  // Detect if we are running on desktop (Windows/macOS/Linux)
  if (!identical(0, 0.0)) {
    // This block only runs on desktop
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
      },
    );
  }
}