import 'dart:async';
import 'dart:convert';

import 'package:auth_one/models/user_model.dart';
import 'package:auth_one/utility/app_url.dart';
import 'package:auth_one/utility/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

// Auth Status as a DataType + Value
enum Status {
  notLoggedIn,
  notRegistered,
  loggedIn,
  registered,
  authenticating,
  registering,
  loggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.notLoggedIn; // Default Value
  Status _registeredStatus = Status.notRegistered; // Default Value

  Status get getLoggedInStatus => _loggedInStatus;
  Status get getRegisteredStatus => _registeredStatus;

  set setLoggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  set setRegisteredStatus(Status value) {
    _registeredStatus = value;
  }

  Future<Map<String, dynamic>> register(String? email, String? password) async {
    final Map<String, dynamic> apiBodyData = {
      'email': email,
      'password': password
    };

    final Map<String, String> headers = {'Content-Type': 'application/json'};

    Uri url = Uri.parse(AppUrl.register);

    return await post(url, body: jsonEncode(apiBodyData), headers: headers)
        .then(onValue)
        .catchError(onError);
  }

  Future<Map<String, dynamic>> login(String? email, String? password) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
      'X-ApiKey': 'ZGlzIzEyMw=='
    };

    _loggedInStatus = Status.authenticating;
    notifyListeners();
    Uri url = Uri.parse(AppUrl.login);
    Response response =
        await post(url, body: jsonEncode(loginData), headers: headers);
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(responseData);

      var userData = responseData['Content'];

      User authUser = User.fromJson(responseData);

      UserPerferences().saveUser(authUser);

      _loggedInStatus = Status.loggedIn;
      notifyListeners();
      result = {
        'status': true,
        'message': "Successfuly Login",
        'data': authUser
      };
    } else {
      _loggedInStatus = Status.notLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': responseData['error'],
      };
    }

    return result;
  }

  static Future<Map<String, dynamic>> onValue(Response response) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    print(responseData);

    if (response.statusCode == 200) {
      var userData = responseData['data'];
      User authUser = User.fromJson(responseData);
      UserPerferences().saveUser(authUser);
      result = {
        'status': true,
        'message': "Successfuly registered",
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': "UnSuccessfuly registered",
        'data': responseData
      };
    }

    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': "UnSuccessfuly request", 'data': error};
  }

  notify() {
    notifyListeners();
  }
}
