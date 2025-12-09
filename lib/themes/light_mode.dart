import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: Colors.green.shade600,
    onPrimary: Colors.white,

    secondary: Colors.green.shade300,
    onSecondary: Colors.black,

    surface: Colors.white,
    onSurface: Colors.black87,

    tertiary: Colors.green.shade50, // background nhẹ cho card/list items
    // Màu nền nhạt dành cho card/list
    surfaceContainerLowest: Colors.green.shade50,   // nhạt nhất
    surfaceContainerLow: Colors.green.shade100,
    surfaceContainer: Colors.green.shade200,
    surfaceContainerHigh: Colors.green.shade300,
    surfaceContainerHighest: Colors.green.shade400, // đậm nhất
  ),
);

