// To parse this JSON data, do
//
//     final locations = locationsFromJson(jsonString);

import 'dart:convert';

Locations locationsFromJson(String str) => Locations.fromJson(json.decode(str));

String locationsToJson(Locations data) => json.encode(data.toJson());

class Locations {
  final List<Location> locations;

  Locations({required this.locations});

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
    locations: List<Location>.from(
      json['results'].map((x) => Location.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    'locations': List<dynamic>.from(locations.map((x) => x.toJson())),
  };
}

class Location {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String country;

  Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json['id'],
    name: json['name'],
    latitude: json['latitude']?.toDouble(),
    longitude: json['longitude']?.toDouble(),
    country: json['country'],
  );

  String toJson() => jsonEncode({
    'id': id,
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
    'country': country,
  });
}
