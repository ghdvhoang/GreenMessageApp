import 'package:flutter/material.dart';
import 'package:green_message_app/services/auth/auth_service.dart';
import 'package:green_message_app/components/my_button.dart';
import 'package:green_message_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  // text editing controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  //tap to login
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // login method
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();
    //try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
      // Successfully signed in
    } catch (e) {
      // Handle sign-in error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),

            SizedBox(height: 50),

            // welcome back text
            Text(
              'Welcome back, you have been missed!',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            SizedBox(height: 25),

            // username textfield
            MyTextField(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),

            SizedBox(height: 25),

            // password textfield
            MyTextField(
              hintText: 'Password',
              obscureText: true,
              controller: _pwController,
            ),

            SizedBox(height: 25),

            // sign in button
            MyButton(text: 'Login', onTap: () => login(context)),

            SizedBox(height: 25),
            // not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Register now',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
