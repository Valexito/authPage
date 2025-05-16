import 'package:authentication_page/pages/home_page.dart';
import 'package:authentication_page/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//This page is for decide the status of the event of MyButton from login_page ... If can be login or not
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //user logged in
            if(snapshot.hasData){
              return HomePage();
            }

          //user not logged in
          else{
            return LoginPage();
          }        
        },
      ),
    );
  }
}