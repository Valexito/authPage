import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showErrorDialog(BuildContext context, String message) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  //EMAIL SIGIN

  Future<void> signInUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (context.mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code} - ${e.message}");

      if (!context.mounted) return;

      showErrorDialog(context, 'Invalid credentials.');
    } catch (e) {
      print("Unexpected error: $e");

      if (!context.mounted) return;
      showErrorDialog(context, 'An unexpected error occurred.');
    }
  }

  //GOOGLE SIGN IN
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //users cancels google sign in in creen.
    if (gUser == null) return;

    //obtain uth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    //create a new credential for user.
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //finally sign in
    return await _auth.signInWithCredential(credential);
  }
}
