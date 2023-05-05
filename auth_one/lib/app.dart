import 'package:auth_one/providers/auth_provider.dart';
import 'package:auth_one/providers/user_provider.dart';
import 'package:auth_one/screens/login_screen.dart';
import 'package:auth_one/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auth One',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
        routes: {
          '/loginScreen': (context) => const LoginScreen(),
          '/registerScreen': (context) => const RegisterScreen(),
          '/dashboard': (context) => const DashBoard(),
        },
      ),
    );
  }
}
