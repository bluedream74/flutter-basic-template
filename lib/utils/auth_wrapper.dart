import 'package:flutter/material.dart';
import 'package:flutter_basic_template/providers/auth_provider.dart';
import 'package:flutter_basic_template/screens/home_screen.dart';
import 'package:flutter_basic_template/screens/login_screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (auth.isAuthenticated) {
          return const HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}