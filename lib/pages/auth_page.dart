import 'package:bsnstat/pages/home_page.dart';
import 'package:bsnstat/pages/login_or_register_page.dart';
import 'package:bsnstat/pages/team_folder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // log in
          if (snapshot.hasData) {
            return TeamFolderPage();
          }
          // not log in
          else {
            return LoginOrRegisterPage();
          }
        }
        ),
    );
  }
}
