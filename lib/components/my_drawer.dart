import 'package:flutter/material.dart';
import 'package:green_message_app/services/auth/auth_service.dart';
import 'package:green_message_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    void logout() {
      // Implement logout functionality
      final auth = AuthService();
      auth.signOut();
    }

    return Drawer(
      backgroundColor: color.tertiary, // NỀN XANH LÁ NHẠT
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // HEADER
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.primary, color.primary.withAlpha(204)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.message, size: 50, color: color.primary),
                ),
                SizedBox(height: 12),
                Text(
                  "Green Message",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          _buildTile(context, icon: Icons.home, text: "Home"),
          // _buildTile(context, icon: Icons.person, text: "Profile"),
          _buildTile(
            context,
            icon: Icons.settings,
            text: "Settings",
            onTap: () {
              Navigator.of(context).pop(); // Đóng Drawer trước
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              ); // Điều hướng
            },
          ),

          // _buildTile(context, icon: Icons.info, text: "About"),
          Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: color.primary,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(Icons.logout),
              label: const Text("Logout"),
              onPressed: logout,
            ),
          ),
        ],
      ),
    );
  }

  // Custom ListTile đẹp hơn
  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    final color = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icon, color: color.primary),
      title: Text(
        text,
        style: TextStyle(
          color: color.primary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}
