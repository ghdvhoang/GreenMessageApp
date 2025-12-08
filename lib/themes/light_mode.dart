import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.white, // Nền sáng
    primary: Colors.green.shade600, // Màu xanh lá chủ đạo
    secondary: Colors.green.shade200, // Xanh lá nhạt
    tertiary: Colors.green.shade50, // Rất nhạt, dùng cho card nhẹ
    inversePrimary: Colors.green.shade900, // Xanh đậm khi cần contrast
  ),
);
