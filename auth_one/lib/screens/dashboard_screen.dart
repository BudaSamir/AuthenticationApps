import 'package:auth_one/models/user_model.dart';
import 'package:auth_one/providers/user_provider.dart';
import 'package:auth_one/utility/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("DASHBOARD PAGE"),
        elevation: 0.1,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(child: Text('${user.email}')),
          SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              UserPerferences().removeUser();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text("Logout"),
          )
        ],
      ),
    );
  }
}
