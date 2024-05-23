import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_basic_template/services/api_service.dart';
import 'package:flutter_basic_template/state/user_state.dart';
import 'package:flutter_basic_template/models/user_model.dart';

void main() {
  test('User login and logout', () {
    final userState = UserState(apiService: ApiService(baseUrl: 'https://api.example.com'));
    final user = UserModel(id: '1', name: 'John Doe', email: 'john.doe@example.com');

    expect(userState.isAuthenticated, false);

    userState.login('email', 'password');
    expect(userState.isAuthenticated, true);
    expect(userState.user, user);

    userState.logout();
    expect(userState.isAuthenticated, false);
    expect(userState.user, null);
  });
}
