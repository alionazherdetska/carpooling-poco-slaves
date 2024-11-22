import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  final String username;
  final String email;
  final String password;
  final String name;
  final String surname;
  final Car car;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.car,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      car: Car.fromJson(json['car'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
      'car': car.toJson(),
    };
  }
}

@JsonSerializable()
class Car {
  final String make;
  final String model;
  final int year;
  @JsonKey(name: 'plate_number')
  final String plateNumber;

  Car({
    required this.make,
    required this.model,
    required this.year,
    required this.plateNumber,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      plateNumber: json['plate_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'year': year,
      'plate_number': plateNumber,
    };
  }
}