import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'wallpaper_setup_screen.dart';

class BrowseCategoryScreen extends StatefulWidget {
  final String category;
  const BrowseCategoryScreen({super.key, required this.category});

  @override
  State<BrowseCategoryScreen> createState() => _BrowseCategoryScreenState();
}

class _BrowseCategoryScreenState extends State<BrowseCategoryScreen> {
  bool _isGrid = true;
  int _selectedIndex = 0;
  bool _isFavorite = false;

  final List<_Wallpaper> _wallpapers = [
    _Wallpaper('Nature 1', 'assets/images/nature1.jpg', ['Nature', 'Ambience', 'Flowers']),
    _Wallpaper('Nature 2', 'assets/images/nature2.jpg', ['Nature', 'Landscape']),
    _Wallpaper('Nature 3', 'assets/images/nature3.jpg', ['Nature', 'Autumn']),
    _Wallpaper('Nature 4', 'assets/images/nature4.jpg', ['Nature', 'Sky']),
    _Wallpaper('Nature 5', 'assets/images/nature5.jpg', ['Nature', 'Night']),
    _Wallpaper('Nature 6', 'assets/images/nature6.jpg', ['Nature', 'Water']),
  ];

  @override
  Widget build(BuildContext context) {
    final wp = _wallpapers[_selectedIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildToggle(),
                  const SizedBox(height: 24),
                  Expanded(child: _isGrid ? _grid() : _list()),
                ],
              ),
            ),
            const SizedBox(width: 60),
            Expanded(flex: 4, child: _preview(wp)),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      leadingWidth: 300,
      title: Row(
        children: [
          Image.asset('assets/logo.png', width: 24, height: 24, color: const Color(0xFFE91E63)),
          const SizedBox(width: 8),
          Text('Wallpaper Studio',
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
        ],
      ),
      actions: [
        _navItem(context, Icons.home, 'Home', '/'),
        const SizedBox(width: 24),
        _navPill(context, 'Browse', '/browse'),
        const SizedBox(width: 24),
        _navItem(context, Icons.favorite_border, 'Favourites', '/favourites'),
        const SizedBox(width: 24),
        _navItem(context, Icons.settings, 'Settings', '/settings'),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _navItem(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, route),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF757575)),
            const SizedBox(width: 6),
            Text(label,
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF757575))),
          ],
        ),
      ),
    );
  }

  Widget _navPill(BuildContext context, String label, String route) {
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
              const Icon(Icons.grid_view, size: 16, color: Colors.black87),
              const SizedBox(width: 6),
              Text(label,
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              const Icon(Icons.arrow_back_ios, size: 16, color: Color(0xFF616161)),
              const SizedBox(width: 4),
              Text('Back to Categories',
                  style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF616161))),
            ],
          ),
        ),
        const Spacer(),
        Text(widget.category,
            style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black)),
        const Spacer(),
      ],
    );
  }

  Widget _buildToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _toggle(Icons.grid_view, _isGrid, () => setState(() => _isGrid = true)),
        const SizedBox(width: 8),
        _toggle(Icons.view_list, !_isGrid, () => setState(() => _isGrid = false)),
      ],
    );
  }

  Widget _toggle(IconData icon, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFFFF3E0) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: const Color(0xFFFF8A65)),
      ),
    );
  }

  Widget _grid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: 0.7,
      ),
      itemCount: _wallpapers.length,
      itemBuilder: (_, i) => _card(i),
    );
  }

  Widget _list() {
    return ListView.separated(
      itemCount: _wallpapers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, i) => _card(i, isList: true),
    );
  }

  Widget _card(int i, {bool isList = false}) {
    final wp = _wallpapers[i];
    final selected = i == _selectedIndex;

    return GestureDetector(
      onTap: () => setState(() {
        _selectedIndex = i;
        _isFavorite = false;
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: selected ? Border.all(color: const Color(0xFFFF8A65), width: 3) : null,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Image.asset(wp.path, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => setState(() => _isFavorite = !_isFavorite),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: _isFavorite ? Colors.red : const Color(0xFF757575),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(wp.name,
                          style: GoogleFonts.inter(
                              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(wp.tags.first,
                            style: GoogleFonts.inter(fontSize: 10, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _preview(_Wallpaper wp) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Text('Preview', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name', style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF757575))),
                    const SizedBox(height: 4),
                    Text(wp.name,
                        style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(height: 16),
                    Text('Tags', style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF757575))),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: wp.tags
                          .map((t) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(t,
                                    style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF424242))),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Text('Description',
                        style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF757575))),
                    const SizedBox(height: 4),
                    Text(
                      'Discover the pure beauty of “${widget.category} Essence” – your gateway to authentic, nature‑inspired experiences.',
                      style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF424242)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    wp.path,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _icon(Icons.download, () {}),
              const SizedBox(width: 16),
              _icon(Icons.share, () {}),
              const SizedBox(width: 16),
              _icon(Icons.info_outline, () {
                Navigator.pushNamed(
                  context,
                  '/wallpaper-setup',
                  arguments: {'name': wp.name, 'path': wp.path},
                );
              }),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => setState(() => _isFavorite = !_isFavorite),
                  icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 18, color: _isFavorite ? Colors.red : const Color(0xFF757575)),
                  label: Text(_isFavorite ? 'Saved' : 'Save to Favorites',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Wallpaper set!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8A65),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text('Set to Wallpaper',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF757575)),
      ),
    );
  }
}

class _Wallpaper {
  final String name;
  final String path;
  final List<String> tags;
  _Wallpaper(this.name, this.path, this.tags);
}