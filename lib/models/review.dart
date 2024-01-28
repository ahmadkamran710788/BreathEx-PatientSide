import 'dart:convert';

class Reviews {
  String id;
  String patient;
  String doctor;
  String appointment;
  String stars;
  String content;
  DateTime createdAt;

  Reviews({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.appointment,
    required this.stars,
    required this.content,
    required this.createdAt,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      id: json['_id'],
      patient: json['patient'],
      doctor: json['doctor'],
      appointment: json['appointment'],
      stars: json['stars'],
      content: json['content'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(), // Provide a default value if createdAt is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patient': patient,
      'doctor': doctor,
      'appointment': appointment,
      'stars': stars,
      'content': content,
      'createdAt': createdAt.toIso8601String() ?? "", // Ensure a non-null value
    };
  }
}
