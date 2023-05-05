import 'package:auth_one/models/user_model.dart';
import 'package:auth_one/providers/auth_provider.dart';
import 'package:auth_one/providers/user_provider.dart';
import 'package:auth_one/utility/validator.dart';
import 'package:auth_one/utility/widgets.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Duration get loginTime => Duration(microseconds: timeDilation.ceil() * 2250);

  final formKey = GlobalKey<FormState>();
  String? _email, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        Text("Registering .... Pleasr Wait"),
      ],
    );

    void register() {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        auth.register(_email, _password).then((respose) {
          if (respose['status']) {
            User user = respose['data'];
            Provider.of<UserProvider>(context).setUser(user);
            Navigator.pushReplacementNamed(context, "/");
          } else {
            Flushbar(
                    title: "Registered Failed",
                    message: respose.toString(),
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register Screen'),
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
                    "Register",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    autofocus: false,
                    // validator: validateEmail,
                    onSaved: ((enteredEmail) => _email = enteredEmail),
                    decoration: buildInputDecoration(
                        hintText: "Enter Your Email", icon: Icons.email),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    validator: validatePassword,
                    onSaved: ((enteredPassword) => _password = enteredPassword),
                    decoration: buildInputDecoration(
                        hintText: "Enter Your Password", icon: Icons.lock),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    validator: _confirmPassword == _password
                        ? validatePassword
                        : validateConfirmPassword,
                    onSaved: ((enteredPassword) =>
                        _confirmPassword = enteredPassword),
                    decoration: buildInputDecoration(
                        hintText: "Confirm Your Password", icon: Icons.lock),
                  ),
                  const SizedBox(height: 20),
                  auth.getLoggedInStatus == Status.authenticating
                      ? loading
                      : longButtons("Register", register),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
