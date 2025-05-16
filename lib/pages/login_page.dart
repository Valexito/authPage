import 'package:authentication_page/components/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authentication_page/components/my_textfield.dart';
import 'package:authentication_page/components/square_tile.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  //Method to sing in
  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),

                // Logo
                const Icon(Icons.lock, size: 85),

                const SizedBox(height: 30),

                // Welcome back
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 25),

                // Username TextField
                MyTextField(
                  controller: emailController, 
                  hintText: 'Email', 
                  obscureText: false),

                const SizedBox(height: 10),

                // Password TextField
               MyTextField(
                controller: passwordController, 
                hintText: 'Password', 
                obscureText: true),

                const SizedBox(height: 10),

                // Forgot Password?
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:  [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Sign In Button
                MyButton(
                  onTap: signUserIn,
                ),

                const SizedBox(height: 30),

                // Or continue with
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children:  [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Or continue with'),
                      ),
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Google + Apple Sign In Buttons (placeholders)
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google button
                  SquareTile(imagePath: 'lib/images/google.png'),

                  const SizedBox(width: 15),
                  //Apple
                  SquareTile(imagePath: 'lib/images/apple.png')
                  ],
                ),

                const SizedBox(height: 30),

                // Not a member? Register now
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                    SizedBox(width: 4),
                    Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}