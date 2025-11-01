import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(), // No leading arrow
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            const SizedBox(height: 32),
            _buildCategoriesGrid(context),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 80,
      automaticallyImplyLeading: false, // REMOVES BACK ARROW
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
        _navIconItem(icon: Icons.home, label: 'Home'),
        const SizedBox(width: 24),
        _navPillItem(icon: Icons.grid_view, label: 'Browse', isActive: true),
        const SizedBox(width: 24),
        _navIconItem(icon: Icons.favorite_border, label: 'Favourites'),
        const SizedBox(width: 24),
        _navIconItem(icon: Icons.settings, label: 'Settings'),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _navPillItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Container(
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
                color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _navIconItem({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF757575)),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF757575)),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Browse Categories',
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
              'Explore our curated collections of stunning wallpapers',
              style: GoogleFonts.inter(
                  fontSize: 16, color: const Color(0xFF616161)),
            ),
          ],
        ),
        // Grid/List Toggle Icons
        Row(
          children: [
            _toggleIcon(icon: Icons.grid_view, isActive: true),
            const SizedBox(width: 8),
            _toggleIcon(icon: Icons.view_list, isActive: false),
          ],
        ),
      ],
    );
  }

  Widget _toggleIcon({required IconData icon, required bool isActive}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFF3E0) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: const Color(0xFFFF8A65)),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 32,
      children: [
        _categoryCard(
          context: context,
          title: 'Nature',
          subtitle: 'Mountains, forest and landscapes',
          count: 3,
          imagePath: 'assets/images/nature.png',
        ),
        _categoryCard(
          context: context,
          title: 'Abstract',
          subtitle: 'Modern Geometric and artistic designs',
          count: 4,
          imagePath: 'assets/images/abstract.png',
        ),
        _categoryCard(
          context: context,
          title: 'Urban',
          subtitle: 'Cities, architecture and street',
          count: 6,
          imagePath: 'assets/images/urban.png',
        ),
        _categoryCard(
          context: context,
          title: 'Space',
          subtitle: 'Cosmos, planets, and galaxies',
          count: 3,
          imagePath: 'assets/images/space.png',
        ),
        _categoryCard(
          context: context,
          title: 'Minimalist',
          subtitle: 'Clean, simple, and elegant',
          count: 6,
          imagePath: 'assets/images/minimalist.png',
        ),
        _categoryCard(
          context: context,
          title: 'Animals',
          subtitle: 'Wildlife and nature photography',
          count: 4,
          imagePath: 'assets/images/animals.png',
        ),
      ],
    );
  }

  Widget _categoryCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required int count,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/category', arguments: title);
      },
      child: Container(
        width: 320,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9)),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$count wallpapers',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}