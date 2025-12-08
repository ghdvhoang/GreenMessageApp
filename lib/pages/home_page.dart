import 'package:flutter/material.dart';
import 'package:green_message_app/auth/auth_service.dart';
import 'package:green_message_app/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    // Implement logout functionality
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          actions: [IconButton(icon: Icon(Icons.logout), onPressed: logout)],
        ),
        drawer: MyDrawer(

        ),
      ),
    );
  }
}
