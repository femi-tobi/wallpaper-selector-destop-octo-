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
  int _displayMode = 0; // 0: Fit, 1: Fill, 2: Stretch, 3: Tile
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
          // LEFT: BLURRED WALLPAPER PREVIEW
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.wallpaperPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(color: Colors.black.withOpacity(0.6)),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.wallpaperName,
                        style: GoogleFonts.inter(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.favorite, color: Colors.red, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Saved to Favorites',
                            style: GoogleFonts.inter(fontSize: 16, color: Colors.white70),
                          ),
                        ],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Wallpaper Setup'),
                  _sectionSubtitle('Configure your wallpaper settings and enable auto-rotation'),
                  const SizedBox(height: 32),

                  // ACTIVATE WALLPAPER
                  _settingCard(
                    title: 'Activate Wallpaper',
                    subtitle: 'Set the selected wallpaper as your desktop background',
                    trailing: _toggleSwitch(_isActivated, (v) => setState(() => _isActivated = v)),
                    badge: 'Activated',
                    badgeColor: Colors.green,
                  ),
                  const SizedBox(height: 24),

                  // DISPLAY MODE
                  _sectionTitle('Display mode'),
                  const SizedBox(height: 12),
                  _radioOption('Fit', 'Scale to fit without cropping', 0),
                  _radioOption('Fill', 'Scale to fill the entire screen', 1),
                  _radioOption('Stretch', 'Stretch to fill the screen', 2),
                  _radioOption('Tile', 'Repeat the image to fill the screen', 3),
                  const SizedBox(height: 32),

                  // AUTO ROTATION
                  _settingCard(
                    title: 'Auto - Rotation',
                    subtitle: 'Automatically change your wallpaper at regular intervals',
                    trailing: _toggleSwitch(_autoRotation, (v) => setState(() => _autoRotation = v)),
                  ),
                  const SizedBox(height: 32),

                  // ADVANCED SETTINGS
                  _sectionTitle('Advanced Settings'),
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
                  const Spacer(),

                  // BUTTONS
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
                          child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
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
        ],
      ),
    );
  }

  // ────────────────────── APP BAR ──────────────────────
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
        _navItem(Icons.home, 'Home'),
        const SizedBox(width: 24),
        _navItem(Icons.grid_view, 'Browse'),
        const SizedBox(width: 24),
        _navItem(Icons.favorite_border, 'Favourites'),
        const SizedBox(width: 24),
        _navItem(Icons.settings, 'Settings'),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _navItem(IconData icon, String label) => Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF757575)),
          const SizedBox(width: 6),
          Text(label,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF757575))),
        ],
      );

  // ────────────────────── HELPERS ──────────────────────
  Widget _sectionTitle(String text) => Text(text,
      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black));

  Widget _sectionSubtitle(String text) => Text(text,
      style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF616161)));

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
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
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
                            style: GoogleFonts.inter(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
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
      activeTrackColor: Colors.green,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: const Color(0xFFE0E0E0),
    );
  }

  Widget _radioOption(String title, String subtitle, int value) {
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
            border: Border.all(color: _displayMode == value ? const Color(0xFFFF8A65) : Colors.transparent, width: 2),
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