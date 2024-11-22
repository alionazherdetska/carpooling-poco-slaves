import '../models/Ride.dart';
import '../models/User.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRepository {

  ///Authentication
  Future<User> loginUser({required String username, required String password});
  Future<User> logoutUser({required String city});

  Future<http.Response> createUser({required User user});
  Future<User?> getUser({required String userId});

  Future<void> postRides({required Ride ride});
}