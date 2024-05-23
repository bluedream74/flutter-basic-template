import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserState with ChangeNotifier {
  UserModel? _user;
  final ApiService apiService;

  UserState({required this.apiService});

  UserModel? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    try {
      _user = await apiService.login(email, password);
      notifyListeners();
    } catch (e) {
      // Handle login error
      rethrow;
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
