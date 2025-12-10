import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.green.shade400,
    onPrimary: Colors.black,

    secondary: Colors.green.shade300,
    onSecondary: Colors.black,

    surface: const Color(0xFF121212), // nền chính
    onSurface: Colors.white70,

    tertiary: Colors.green.shade800, // xanh đậm dùng cho card/chat bubble dark
    // Surface variants trong dark mode (từ nhạt -> đậm)
    surfaceContainerLowest: const Color(0xFF1A1A1A),
    surfaceContainerLow: const Color(0xFF1F1F1F),
    surfaceContainer: const Color(0xFF242424),
    surfaceContainerHigh: const Color(0xFF2C2C2C),
    surfaceContainerHighest: const Color(0xFF333333),
  ),
);
