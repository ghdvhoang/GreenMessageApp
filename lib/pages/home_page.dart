import 'package:flutter/material.dart';
import 'package:green_message_app/components/my_drawer.dart';
import 'package:green_message_app/components/user_tile.dart';
import 'package:green_message_app/pages/chat_page.dart';
import 'package:green_message_app/services/auth/auth_service.dart';
import 'package:green_message_app/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat and auth service instances
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(title: Text('Home')),
        drawer: MyDrawer(),
        body: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStreams(),
      builder: (context, snapshot) {
        //error handling
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        //loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        // return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    //display all user except current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'] ?? 'No Name',
        onTap: () {
          //tap on a user -> chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChatPage(
                    receiverEmail: userData['email'] ?? 'No Name',
                    receiverID: userData['uid'] ?? ''),
            ),
          );
        },
      );
    }
    else {
      return SizedBox.shrink();
    }
  }
}
