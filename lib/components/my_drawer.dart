import 'package:flutter/material.dart';
import 'package:green_message_app/services/auth/auth_service.dart';
import 'package:green_message_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    void logout() {
      final auth = AuthService();
      auth.signOut();
    }

    return Drawer(
      backgroundColor: color.surfaceContainerLow, // Hợp cả light & dark
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // HEADER (đẹp cả 2 theme)
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.primary, color.primary.withValues(alpha: 0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.message, size: 48, color: color.primary),
                ),
                SizedBox(height: 12),
                Text(
                  "Green Message",
                  style: TextStyle(
                    color: color.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12),

          _buildTile(context, icon: Icons.home, text: "Home"),
          _buildTile(context, icon: Icons.person, text: "Profile"),

          _buildTile(
            context,
            icon: Icons.settings,
            text: "Settings",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsPage()),
              );
            },
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: color.primary,
                foregroundColor: color.onPrimary,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              onPressed: logout,
            ),
          ),
        ],
      ),
    );
  }

  // Custom Drawer Tile
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
          color: color.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      hoverColor: color.primary.withValues(alpha: 0.05),
      splashColor: color.primary.withValues(alpha: 0.1),
    );
  }
}
