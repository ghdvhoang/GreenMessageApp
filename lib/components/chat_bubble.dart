import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // màu bong bóng
    final bubbleColor = isCurrentUser
        ? colors.primary
        : colors.surfaceContainerHigh;

    // màu chữ
    final textColor = isCurrentUser
        ? colors.onPrimary
        : colors.onSurface;

    return Container(
      margin: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: isCurrentUser ? 40 : 12,
        right: isCurrentUser ? 12 : 40,
      ),
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isCurrentUser ? 16 : 4),
            bottomRight: Radius.circular(isCurrentUser ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
