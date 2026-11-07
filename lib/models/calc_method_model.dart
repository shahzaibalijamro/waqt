import 'dart:convert';

class CalculationMethod {
  final int id;
  final String name;

  const CalculationMethod({required this.id, required this.name});

  String toJson(CalculationMethod method) {
    return jsonEncode({'id': method.id, 'name': method.name});
  }

  factory CalculationMethod.fromJson(Map<String, dynamic> json) {
    return CalculationMethod(id: json['id'], name: json['name']);
  }
}
