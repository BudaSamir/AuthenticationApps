import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:auth_one/models/user_model.dart';
import 'package:auth_one/providers/auth_provider.dart';
import 'package:auth_one/providers/user_provider.dart';
import 'package:auth_one/utility/validator.dart';
import 'package:auth_one/utility/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String? _email, _password;
  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      CircularProgressIndicator(),
      Text("Logining .... Please Wait"),
    ],
  );
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    void login() {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        final Future<Map<String, dynamic>> response =
            auth.login(_email, _password);

        response.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, "/");
          } else {
            Flushbar(
                    title: "Registered Failed",
                    message: response.toString(),
                    duration: const Duration(seconds: 10))
                .show(context);
          }
        });
      } else {
        Flushbar(
                title: "Invalid Form",
                message: 'please complete the form properly',
                duration: const Duration(seconds: 10))
            .show(context);
      }
    }

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0.0),
            ),
            onPressed: () {
              // Navigator.pushReplacementNamed(context, '/reset-password');
            },
            child: const Text(
              "Forgot Your Password?",
              style: TextStyle(fontWeight: FontWeight.w300),
            )),
        TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(left: 0.0),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/registerScreen');
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.w300),
            ))
      ],
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 60),
                  TextFormField(
                    autofocus: false,
                    validator: validateEmail,
                    onSaved: ((enteredEmail) => _email = enteredEmail),
                    decoration: buildInputDecoration(
                        hintText: "Enter Your Email", icon: Icons.email),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    validator: validatePassword,
                    onSaved: ((enteredPassword) => _password = enteredPassword),
                    decoration: buildInputDecoration(
                        hintText: "Enter Your Password", icon: Icons.lock),
                  ),
                  const SizedBox(height: 20),
                  auth.getLoggedInStatus == Status.authenticating
                      ? loading
                      : longButtons("Login", login),
                  forgotLabel,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
