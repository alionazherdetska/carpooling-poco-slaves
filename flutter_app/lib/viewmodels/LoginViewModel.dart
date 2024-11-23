import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:poco_hackers_app/repo/AuthenticationApi.dart';

import '../models/User.dart';

class LoginViewModel {
  final AuthenticationRepository _authRepo;

  LoginViewModel(this._authRepo);

  void signInUser(String username, String password) async {
    _authRepo.loginUser(username, password);
  }

  void signUpUser(User user) async {
    var result = await _authRepo.createUser(user: user);
    print("get result: $result");
  }

  void getUser(String userId){
    _authRepo.getUser(userId: 'userId');
  }
}
