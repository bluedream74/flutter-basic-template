import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Example of a login function
  Future<UserModel?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Assuming the API returns user data in the response
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      // Handle error
      throw Exception('Failed to login');
    }
  }

  // Example of a function to fetch user data
  Future<UserModel?> fetchUserData(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      // Handle error
      throw Exception('Failed to fetch user data');
    }
  }

  // Example of a function to update user data
  Future<UserModel?> updateUserData(String userId, Map<String, dynamic> userData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      // Handle error
      throw Exception('Failed to update user data');
    }
  }
}
