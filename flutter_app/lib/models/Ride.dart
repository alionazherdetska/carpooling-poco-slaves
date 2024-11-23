import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Ride {
  final String origin;
  @JsonKey(name: 'origin_latitude')
  final double originLatitude;
  @JsonKey(name: 'origin_longitude')
  final double originLongitude;
  final String destination;
  @JsonKey(name: 'destination_latitude')
  final double destinationLatitude;
  @JsonKey(name: 'destination_longitude')
  final double destinationLongitude;
  @JsonKey(name: 'departure_time')
  final DateTime departureTime;
  @JsonKey(name: 'available_seats')
  final int availableSeats;
  @JsonKey(name: 'driver_id')
  final int driverId;

  Ride({
    required this.origin,
    required this.originLatitude,
    required this.originLongitude,
    required this.destination,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.departureTime,
    required this.availableSeats,
    required this.driverId,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      origin: json['origin'] as String,
      originLatitude: json['origin_latitude'] as double,
      originLongitude: json['origin_longitude'] as double,
      destination: json['destination'] as String,
      destinationLatitude: json['destination_latitude'] as double,
      destinationLongitude: json['destination_longitude'] as double,
      departureTime: DateTime.parse(json['departure_time'] as String),
      availableSeats: json['available_seats'] as int,
      driverId: json['driver_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'origin': origin,
      'origin_latitude': originLatitude,
      'origin_longitude': originLongitude,
      'destination': destination,
      'destination_latitude': destinationLatitude,
      'destination_longitude': destinationLongitude,
      'departure_time': departureTime.toIso8601String(),
      'available_seats': availableSeats,
      'driver_id': driverId,
    };
  }
}