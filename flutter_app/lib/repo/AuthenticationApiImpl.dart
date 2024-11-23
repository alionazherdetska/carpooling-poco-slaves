import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:poco_hackers_app/constants/CApi.dart';
import 'package:poco_hackers_app/constants/ENavigation.dart';

import '../models/Ride.dart';
import '../models/User.dart';
import 'AuthenticationApi.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(); //{required this.client}
  // final http.Client client;
  final _storage = const FlutterSecureStorage();

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
  Future<void> loginUser(String username, String password) async {
    final url = Uri.parse(baseUrl + EApiRoutes.login.path);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];

      // Save the JWT token securely
      await _storage.write(key: 'jwt_token', value: token);

      print('Login successful! Token: $token');
    } else {
      try {
        throw Exception('Failed');
      } catch (e, stack) {
        debugPrintStack(stackTrace: stack);
      }    }
  }

  Future<bool> isTokenExpired() async {
    final token = await _storage.read(key: 'jwt_token');
    if (token == null) return true;

    return JwtDecoder.isExpired(token);
  }
}
