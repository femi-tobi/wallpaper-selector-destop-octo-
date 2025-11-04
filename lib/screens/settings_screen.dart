import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _imageQuality = 'High (Best Quality)';
  bool _notifications = true;

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
            const SizedBox(height: 60),
            Expanded(child: _buildMainCard()),
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
        _navItem(context, Icons.grid_view, 'Browse', '/browse'),
        const SizedBox(width: 24),
        _navItem(context, Icons.favorite_border, 'Favourites', '/favourites'),
        const SizedBox(width: 24),
        _navPill(context, 'Settings', '/settings'),
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
              const Icon(Icons.settings, size: 16, color: Colors.black87),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
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
          'Customize your Wallpaper Studio experience',
          style: GoogleFonts.inter(fontSize: 16, color: const Color(0xFF616161)),
        ),
      ],
    );
  }

  Widget _buildMainCard() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Wallpaper Setup',
                    style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Configure your wallpaper settings and enable auto-rotation',
                    style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF616161))),
                const SizedBox(height: 32),
                _buildDropdownField(
                  label: 'Image Quality',
                  value: _imageQuality,
                  items: ['High (Best Quality)', 'Medium', 'Low (Fastest)'],
                  onChanged: (val) => setState(() => _imageQuality = val!),
                ),
                const SizedBox(height: 24),
                _buildSwitchField(
                  label: 'Notification',
                  subtitle: 'Get notified about new wallpapers and updates',
                  value: _notifications,
                  onChanged: (val) => setState(() => _notifications = val),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      label: 'Cancel',
                      backgroundColor: const Color(0xFFF5F5F5),
                      textColor: const Color(0xFF757575),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 16),
                    _buildButton(
                      label: 'Save Settings',
                      backgroundColor: const Color(0xFFFF8A65),
                      textColor: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Settings saved!')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 60),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/phone_mockup.png', width: 240, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchField({
    required String label,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(subtitle, style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF616161))),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFFFF8A65),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
      ),
      child: Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
    );
  }
}