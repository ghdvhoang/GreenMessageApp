import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_message_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // GENERAL SECTION TITLE
          Text(
            "Appearance",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colors.onSurface.withAlpha(179),
            ),
          ),

          const SizedBox(height: 12),

          // SWITCH ITEM CARD
          Container(
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.dark_mode, color: colors.primary),
              title: const Text(
                "Dark Mode",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              trailing: CupertinoSwitch(
                value: Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).isDarkMode,
                onChanged: (value) => Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).toggleTheme(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
