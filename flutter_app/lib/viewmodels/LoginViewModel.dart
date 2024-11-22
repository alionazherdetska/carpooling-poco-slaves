import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:poco_hackers_app/repo/AuthenticationApi.dart';

import '../models/User.dart';

class LoginViewModel {
  final AuthenticationRepository _authRepo;

  LoginViewModel(this._authRepo);

  void signInUser(String username, String password) async {
    _authRepo.loginUser(username: username, password: password);
  }

  void signUpUser(User? user) async {
    var userJSON = """
   {
  "username": "string2",
  "email": "user2@example.com",
  "password": "string",
  "name": "string",
  "surname": "string",
  "car": {
    "make": "string",
    "model": "string",
    "year": 0,
    "plate_number": "string"
  }
}""";

    User _user = User.fromJson(jsonDecode(userJSON) as Map<String, dynamic>);
    var result = await _authRepo.createUser(user: _user);
    print("get result: $result");
  }

  void getUser(String userId){
    _authRepo.getUser(userId: 'userId');
  }
}
