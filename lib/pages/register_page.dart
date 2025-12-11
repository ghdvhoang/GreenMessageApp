import 'package:flutter/material.dart';
import 'package:green_message_app/services/auth/auth_service.dart';
import 'package:green_message_app/components/my_button.dart';
import 'package:green_message_app/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, required this.onTap});

  final void Function()? onTap;

  // text editing controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  // register method
  void register(BuildContext context) async {
    final auth = AuthService();
    //check if passwords match -> create user
    if (_pwController.text == _confirmPwController.text) {
      try {
        auth.signUpWithEmailPassword(_emailController.text, _pwController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sign up Failed'),
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
    } else {
      //passwords do not match
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign up Failed'),
          content: Text('Passwords do not match'),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 75),
          child: Center(
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
                  'Let\'s create an account for you!',
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
                // confirm password textfield
                MyTextField(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  controller: _confirmPwController,
                ),

                SizedBox(height: 25),

                // sign in button
                MyButton(text: 'Register', onTap: () => register(context)),

                SizedBox(height: 25),
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        'Login now',
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
        ),
      ),
    );
  }
}
