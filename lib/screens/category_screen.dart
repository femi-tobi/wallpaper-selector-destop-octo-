import 'package:flutter/material.dart';
import '../widgets/wallpaper_grid.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const _Sidebar(currentRoute: '/category'),
          Expanded(
            child: Column(
              children: [
                const _Header(title: 'Nature'), // change per category
                const Expanded(child: WallpaperGrid()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Re-use the same _Sidebar and _Header from home_screen.dart
class _Sidebar extends StatelessWidget {
  final String currentRoute;
  const _Sidebar({required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          const SizedBox(height: 64),
          _SidebarItem(
            icon: Icons.home,
            label: 'Home',
            route: '/',
            isActive: currentRoute == '/',
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          _SidebarItem(
            icon: Icons.grid_on,
            label: 'Categories',
            route: '/category',
            isActive: currentRoute == '/category',
            onTap: () => Navigator.pushReplacementNamed(context, '/category'),
          ),
          _SidebarItem(
            icon: Icons.favorite,
            label: 'Favorites',
            route: '/favorites',
            isActive: currentRoute == '/favorites',
            onTap: () => Navigator.pushReplacementNamed(context, '/favorites'),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              '© 2025 Wallpaper Selector',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
          color: isActive ? const Color(0xFF00C853) : Colors.white, size: 20),
      title: Text(label,
          style: TextStyle(
              color: isActive ? const Color(0xFF00C853) : Colors.white,
              fontSize: 14)),
      selected: isActive,
      selectedTileColor: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const Spacer(),
          SizedBox(
            width: 320,
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search wallpapers...',
                hintStyle:
                    const TextStyle(color: Color(0xFFB3B3B3), fontSize: 14),
                prefixIcon:
                    const Icon(Icons.search, color: Color(0xFFB3B3B3), size: 18),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}