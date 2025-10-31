import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            const SizedBox(height: 48),
            _buildCategoriesSection(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png', // You'll need to add this logo
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
        _navItem('Home', isActive: true),
        _navItem('Browse'),
        _navItem('Favourites'),
        _navItem('Settings'),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _navItem(String text, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          color: isActive ? Colors.black : const Color(0xFF757575),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discover Beautiful Wallpapers',
          style: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            height: 1.1,
            letterSpacing: -0.5,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [Color(0xFFFFD54F), Color(0xFFE91E63)],
              ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Discover curated collections of stunning wallpapers. Browse by\ncategory, preview in full-screen, and set your favorites.',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: const Color(0xFF616161),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xFF757575),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 24,
          runSpacing: 32,
          children: [
            _categoryCard(
              title: 'Nature',
              subtitle: 'Mountains, forest and landscapes',
              count: 3,
              image: 'https://picsum.photos/seed/nature/600/400',
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
              ),
            ),
            _categoryCard(
              title: 'Abstract',
              subtitle: 'Modern Geometric and artistic designs',
              count: 4,
              image: 'https://picsum.photos/seed/abstract/600/400',
              gradient: const LinearGradient(
                colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
              ),
            ),
            _categoryCard(
              title: 'Urban',
              subtitle: 'Cities, architecture and street',
              count: 6,
              image: 'https://picsum.photos/seed/urban/600/400',
              gradient: const LinearGradient(
                colors: [Color(0xFF607D8B), Color(0xFF455A64)],
              ),
            ),
            _categoryCard(
              title: 'Space',
              subtitle: 'Cosmos, planets, and galaxies',
              count: 3,
              image: 'https://picsum.photos/seed/space/600/400',
              gradient: const LinearGradient(
                colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
              ),
            ),
            _categoryCard(
              title: 'Minimalist',
              subtitle: 'Clean, simple, and elegant',
              count: 6,
              image: 'https://picsum.photos/seed/minimal/600/400',
              gradient: const LinearGradient(
                colors: [Color(0xFFBCAAA4), Color(0xFF8D6E63)],
              ),
            ),
            _categoryCard(
              title: 'Animals',
              subtitle: 'Wildlife and nature photography',
              count: 4,
              image: 'https://picsum.photos/seed/animals/600/400',
              gradient: const LinearGradient(
                colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _categoryCard({
    required String title,
    required String subtitle,
    required int count,
    required String image,
    required Gradient gradient,
  }) {
    return SizedBox(
      width: 320,
      height: 200,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                color: const Color(0x80000000),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: gradient,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$count wallpapers',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}