import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WallpaperSetupScreen extends StatefulWidget {
  final String wallpaperName;
  final String wallpaperPath;

  const WallpaperSetupScreen({
    super.key,
    required this.wallpaperName,
    required this.wallpaperPath,
  });

  @override
  State<WallpaperSetupScreen> createState() => _WallpaperSetupScreenState();
}

class _WallpaperSetupScreenState extends State<WallpaperSetupScreen> {
  bool _isActivated = true;
  int _displayMode = 0;
  bool _autoRotation = false;
  bool _lockWallpaper = true;
  bool _syncAcrossDevices = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Row(
        children: [
          // LEFT: WHITE + DIMMED WALLPAPER + GRID
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(color: Colors.white),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.wallpaperPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(color: Colors.black.withOpacity(0.5)),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.wallpaperName.split(' ').first,
                        style: GoogleFonts.inter(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: 6,
                          itemBuilder: (_, i) {
                            final path = 'assets/images/nature${i + 1}.jpg';
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage(path),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    'Nature ${i + 1}',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // RIGHT: SETTINGS PANEL
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wallpaper Setup',
                      style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Configure your wallpaper settings and enable auto-rotation',
                      style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF616161)),
                    ),
                    const SizedBox(height: 32),

                    _settingCard(
                      title: 'Activate Wallpaper',
                      subtitle: 'Set the selected wallpaper as your desktop background',
                      trailing: _toggleSwitch(_isActivated, (v) => setState(() => _isActivated = v)),
                      badge: 'Activated',
                      badgeColor: const Color(0xFF4CAF50),
                    ),
                    const SizedBox(height: 32),

                    Text('Display mode', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    _radioOption('Fit', 'Scale to fit without cropping', 0),
                    _radioOption('Fill', 'Scale to fill the entire screen', 1),
                    _radioOption('Stretch', 'Stretch to fill the screen', 2),
                    _radioOption('Tile', 'Repeat the image to fill the screen', 3),
                    const SizedBox(height: 32),

                    _settingCard(
                      title: 'Auto - Rotation',
                      subtitle: 'Automatically change your wallpaper at regular intervals',
                      trailing: _toggleSwitch(_autoRotation, (v) => setState(() => _autoRotation = v)),
                    ),
                    const SizedBox(height: 32),

                    Text('Advanced Settings', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    _settingCard(
                      title: 'Lock Wallpaper',
                      subtitle: 'Prevent accidental changes',
                      trailing: _toggleSwitch(_lockWallpaper, (v) => setState(() => _lockWallpaper = v)),
                    ),
                    const SizedBox(height: 16),
                    _settingCard(
                      title: 'Sync Across Devices',
                      subtitle: 'Keep wallpaper consistent on all devices',
                      trailing: _toggleSwitch(_syncAcrossDevices, (v) => setState(() => _syncAcrossDevices = v)),
                    ),
                    const SizedBox(height: 40),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(color: Color(0xFFE0E0E0)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Text('Cancel',
                                style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(0xFF757575))),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Settings saved!')),
                              );
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF8A65),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Text('Save Settings',
                                style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ────────────────────── APP BAR WITH FULL NAVIGATION ──────────────────────
  PreferredSizeWidget _buildAppBar() {
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
        _navItem(Icons.home, 'Home', '/'),
        const SizedBox(width: 24),
        _navPill('Browse', '/browse'),
        const SizedBox(width: 24),
        _navItem(Icons.favorite_border, 'Favourites', '/favourites'),
        const SizedBox(width: 24),
        _navItem(Icons.settings, 'Settings', '/settings'),
        const SizedBox(width: 40),
      ],
    );
  }

  // NAV ITEM WITH ROUTE
  Widget _navItem(IconData icon, String label, String route) {
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

  // BROWSE PILL WITH ROUTE
  Widget _navPill(String label, String route) {
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

  // ────────────────────── HELPERS ──────────────────────
  Widget _settingCard({
    required String title,
    required String subtitle,
    required Widget trailing,
    String? badge,
    Color? badgeColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                    if (badge != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(badge,
                            style: GoogleFonts.inter(
                                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF616161))),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _toggleSwitch(bool value, Function(bool) onChanged) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: Colors.white,
      activeTrackColor: const Color(0xFF4CAF50),
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: const Color(0xFFE0E0E0),
    );
  }

  Widget _radioOption(String title, String subtitle, int value) {
    final isSelected = _displayMode == value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => setState(() => _displayMode = value),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? const Color(0xFFFF8A65) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Radio<int>(
                value: value,
                groupValue: _displayMode,
                onChanged: (v) => setState(() => _displayMode = v!),
                activeColor: const Color(0xFFFF8A65),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                    Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF616161))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}