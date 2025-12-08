import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: color.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // HEADER
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.primary,
                  color.primary.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: color.primary,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Green Message",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 16),

          // MENU ITEMS
          _buildTile(
            context,
            icon: Icons.home,
            text: "Home",
          ),
          _buildTile(
            context,
            icon: Icons.person,
            text: "Profile",
          ),
          _buildTile(
            context,
            icon: Icons.settings,
            text: "Settings",
          ),
          _buildTile(
            context,
            icon: Icons.info,
            text: "About",
          ),

          Spacer(),

          // LOGOUT
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
              label: Text("Logout"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  // Custom ListTile đẹp hơn
  Widget _buildTile(BuildContext context,
      {required IconData icon, required String text}) {
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
      onTap: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}
