import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  bool _isGridView = true;

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
            const SizedBox(height: 32),
            _isGridView ? _buildGridView(context) : _buildListView(context),
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
        Row(
          children: [
            _toggleButton(
              icon: Icons.grid_view,
              isActive: _isGridView,
              onTap: () => setState(() => _isGridView = true),
            ),
            const SizedBox(width: 8),
            _toggleButton(
              icon: Icons.view_list,
              isActive: !_isGridView,
              onTap: () => setState(() => _isGridView = false),
            ),
          ],
        ),
      ],
    );
  }

  Widget _toggleButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFFF3E0) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: const Color(0xFFFF8A65)),
      ),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 32,
      children: _buildCategoryCards(context),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Column(
      children: _buildCategoryCards(context).map((card) {
        final data = card.key as _CategoryData;
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/category', arguments: data.title),
          child: Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    data.imagePath,
                    width: 120,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.subtitle,
                        style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF616161)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${data.count} wallpapers',
                          style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF757575)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  List<GestureDetector> _buildCategoryCards(BuildContext context) {
    final categories = [
      _CategoryData('Nature', 'Mountains, forest and landscapes', 3, 'assets/images/nature.png'),
      _CategoryData('Abstract', 'Modern Geometric and artistic designs', 4, 'assets/images/abstract.png'),
      _CategoryData('Urban', 'Cities, architecture and street', 6, 'assets/images/urban.png'),
      _CategoryData('Space', 'Cosmos, planets, and galaxies', 3, 'assets/images/space.png'),
      _CategoryData('Minimalist', 'Clean, simple, and elegant', 6, 'assets/images/minimalist.png'),
      _CategoryData('Animals', 'Wildlife and nature photography', 4, 'assets/images/animals.png'),
    ];

    return categories.map((data) {
      return GestureDetector(
        key: ValueKey(data),
        onTap: () => Navigator.pushNamed(context, '/category', arguments: data.title),
        child: Container(
          width: 320,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(data.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                Text(data.subtitle, style: GoogleFonts.inter(fontSize: 14, color: Colors.white.withOpacity(0.9))),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${data.count} wallpapers',
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}

class _CategoryData {
  final String title, subtitle, imagePath;
  final int count;
  _CategoryData(this.title, this.subtitle, this.count, this.imagePath);
}