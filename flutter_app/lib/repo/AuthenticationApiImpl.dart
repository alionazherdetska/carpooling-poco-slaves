import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:poco_hackers_app/constants/CApi.dart';
import 'package:poco_hackers_app/constants/ENavigation.dart';

import '../models/Ride.dart';
import '../models/User.dart';
import 'AuthenticationApi.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(); //{required this.client}
  // final http.Client client;

  @override
  Future<http.Response> createUser({required User user}) {
    return http.post(Uri.parse(baseUrl + EApiRoutes.createUser.path),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
  }

  ///Authentication

  Future<User> logoutUser({required String city}) {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  Future<User?> getUser({required String userId}) async {
    final response =
        await http.get(Uri.parse(baseUrl + EApiRoutes.getUser.path));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      try {
        throw Exception('Failed');
      } catch (e, stack) {
        debugPrintStack(stackTrace: stack);
      }
    }

    return null;
  }

  @override
  Future<void> postRides({required Ride ride}) {
    // TODO: implement postRides
    throw UnimplementedError();
  }

  @override
  Future<User> loginUser({required String username, required String password}) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }
}
