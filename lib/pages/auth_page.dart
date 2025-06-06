import 'package:authentication_page/pages/home_page.dart';
import 'package:authentication_page/pages/login_page.dart';
import 'package:authentication_page/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// AuthPage decides whether to show Login or Home/Register based on auth state
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is logged in
        if (snapshot.hasData) {
          return HomePage();
        }

        // User is not logged in
        if (showLoginPage) {
          return LoginPage(showRegisterPage: toggleScreens);
        } else {
          return RegisterPage(showLoginPage: toggleScreens);
        }
      },
    );
  }
}
