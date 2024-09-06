import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_todo_app/presentation/auth/signin_page.dart';
import 'package:firebase_todo_app/presentation/home/home_page.dart';

import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SigninPage();
        }
        return const HomePage();
      },
    );
  }
}
