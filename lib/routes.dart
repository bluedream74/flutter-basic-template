import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => LoginScreen(),
    '/home': (context) => const HomeScreen(),
  };
}
