import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_message_app/components/chat_bubble.dart';
import 'package:green_message_app/services/auth/auth_service.dart';
import 'package:green_message_app/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // for textfield focus
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollDown();
          });
        });
      }
    });

    // wait a bit for listview to be built, then scroll down
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    _messageController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // send message function would be implemented here
  void _sendMessage() async {
    // implementation for sending message
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text,
      );
      _messageController.clear();

      // call scroll down

      Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          widget.receiverEmail,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 1,
        scrolledUnderElevation: 2,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),

      body: Column(
        children: [
          Expanded(child: _buildMessagesList()),

          // INPUT FIELD
          _buildUserInput(context),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderID, widget.receiverID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        //loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        //final messages = snapshot.data!.docs;
        // return list view of messages
        return ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  // build individual message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //currnt user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    //left for others
    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data['message'] ?? '',
            isCurrentUser: isCurrentUser,
          ),
        ],
      ),
    );
  }

  Widget _buildUserInput(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: colors.primary.withValues(alpha: 0.20),
                  width: 1.2,
                ),
              ),
              child: TextField(
                controller: _messageController,
                focusNode: myFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Send button đẹp (circle button)
          InkWell(
            onTap: _sendMessage,
            borderRadius: BorderRadius.circular(28),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.send, color: colors.onPrimary, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
