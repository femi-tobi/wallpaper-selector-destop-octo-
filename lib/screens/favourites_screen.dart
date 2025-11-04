import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 80),
            Expanded(child: _buildEmptyState(context)),
          ],
        ),
      ),
    );
  }

  // ────────────────────── APP BAR WITH FULL NAVIGATION ──────────────────────
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      leadingWidth: 300,
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png',
            width: 24,
            height: 24,
            color: const Color(0xFFE91E63),
          ),
          const SizedBox(width: 8),
          Text(
            'Wallpaper Studio',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
      actions: [
        _navIconItem(context, icon: Icons.home, label: 'Home', route: '/'),
        const SizedBox(width: 24),
        _navIconItem(context, icon: Icons.grid_view, label: 'Browse', route: '/browse'),
        const SizedBox(width: 24),
        _navPillItem(context, icon: Icons.favorite, label: 'Favourites', route: '/favourites', isActive: true),
        const SizedBox(width: 24),
        _navIconItem(context, icon: Icons.settings, label: 'Settings', route: '/settings'),
        const SizedBox(width: 40),
      ],
    );
  }

  // ────────────────────── NAVIGATION HELPERS ──────────────────────
  Widget _navIconItem(BuildContext context, {required IconData icon, required String label, required String route}) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, route),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF757575)),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF757575),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navPillItem(BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, route),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.black87),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ────────────────────── HEADER ──────────────────────
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Saved Wallpapers',
          style: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            height: 1.1,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [Color(0xFFFFD54F), Color(0xFFE91E63)],
              ).createShader(const Rect.fromLTWH(0, 0, 600, 70)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your saved wallpapers collection',
          style: GoogleFonts.inter(fontSize: 16, color: const Color(0xFF616161)),
        ),
      ],
    );
  }

  // ────────────────────── EMPTY STATE ──────────────────────
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_saved_wallpapers.png',
            width: 180,
            height: 180,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 32),
          Text(
            'No Saved Wallpapers',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start saving your favorite wallpapers to see them here',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF757575),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/browse'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8A65),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Text(
              'Browse Wallpapers',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}