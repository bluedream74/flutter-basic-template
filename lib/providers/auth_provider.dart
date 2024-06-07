import 'package:flutter/material.dart';
import 'package:flutter_basic_template/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String username, String password) async {
    _isAuthenticated = await _authService.login(username, password);
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    _isAuthenticated = await _authService.isAuthenticated();
    notifyListeners();
  }

  Future<void> scheduleTokenRefresh() async {
    _authService.scheduleTokenRefresh();
  }
}
