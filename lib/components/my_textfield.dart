import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type a message...',
          // hintStyle: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}
