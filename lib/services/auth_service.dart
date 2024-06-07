import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  final storage = const FlutterSecureStorage();
  final String loginUrl = 'https://yourapi.com/login';
  final String refreshUrl = 'https://yourapi.com/refresh';

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String accessToken = data['accessToken'];
      String refreshToken = data['refreshToken'];
      await storage.write(key: 'accessToken', value: accessToken);
      await storage.write(key: 'refreshToken', value: refreshToken);
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
  }

  Future<bool> isAuthenticated() async {
    String? accessToken = await storage.read(key: 'accessToken');
    if (accessToken == null || JwtDecoder.isExpired(accessToken)) {
      return await _refreshToken();
    }
    return true;
  }

  Future<bool> _refreshToken() async {
    String? refreshToken = await storage.read(key: 'refreshToken');
    if (refreshToken == null) return false;

    final response = await http.post(
      Uri.parse(refreshUrl),
      body: jsonEncode(<String, String>{
        'refreshToken': refreshToken,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String newAccessToken = data['accessToken'];
      await storage.write(key: 'accessToken', value: newAccessToken);
      return true;
    } else {
      await logout();
      return false;
    }
  }

  Future<void> scheduleTokenRefresh() async {
    final accessToken = await storage.read(key: 'accessToken');
    if (accessToken != null) {
      final expirationTime = JwtDecoder.getExpirationDate(accessToken);
      final now = DateTime.now();
      final refreshTime = expirationTime.subtract(const Duration(minutes: 5));
      if (now.isBefore(refreshTime)) {
        await Future.delayed(refreshTime.difference(now), () async {
          await _refreshToken();
          await scheduleTokenRefresh();
        });
      }
    }
  }

}
