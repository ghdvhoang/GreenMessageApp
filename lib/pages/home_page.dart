import 'package:flutter/material.dart';
import 'package:green_message_app/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        drawer: MyDrawer(

        ),
      ),
    );
  }
}
