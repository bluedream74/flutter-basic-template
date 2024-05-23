import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/user_state.dart';
import 'state/settings_state.dart';
import 'services/api_service.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserState(apiService: ApiService(baseUrl: 'https://api.example.com')),
        ),
        ChangeNotifierProvider(create: (_) => SettingsState()),
      ],
      child: MaterialApp(
        title: 'My Complex App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: Routes.routes,
        initialRoute: '/',
      ),
    );
  }
}
