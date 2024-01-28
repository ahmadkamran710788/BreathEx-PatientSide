import 'dart:convert';

class Prescription {
  String id;
  String patient;
  String doctor;
  String appointment;
  List<Medicine> prescription;
  DateTime? createdAt; // Make createdAt nullable

  Prescription({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.appointment,
    required this.prescription,
    required this.createdAt,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['_id'],
      patient: json['patient'],
      doctor: json['doctor'],
      appointment: json['appointment'],
      prescription: (json['prescription'] as List<dynamic>?)
          ?.map((item) => Medicine.fromJson(item as Map<String, dynamic>))
          ?.toList() ?? [], // Provide a default value for the list
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id, // Include '_id' in the JSON representation
      'patient': patient,
      'doctor': doctor,
      'appointment': appointment,
      'prescription': prescription.map((medicine) => medicine.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(), // Convert DateTime to string
    };
  }
}

class Medicine {
  String medicineName;
  String duration;
  String dosage;
  String directions;

  Medicine({
    required this.medicineName,
    required this.duration,
    required this.dosage,
    required this.directions,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineName: json['medicineName'],
      duration: json['duration'],
      dosage: json['dosage'],
      directions: json['directions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineName': medicineName,
      'duration': duration,
      'dosage': dosage,
      'directions': directions,
    };
  }
}
