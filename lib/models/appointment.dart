class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final String date;
  final String slot;
  final String status;
  final String doctorName;
  List<String> doctorImageUrl;
  final bool reviewGiven;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.date,
    required this.slot,
    required this.status,
    required this.doctorName,
    required this.doctorImageUrl,
    required this.reviewGiven,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'] ?? '',
      patientId: json['patientId'] ?? '',
      doctorId: json['doctorId']['_id'] ?? '',
      date: json['date'] ?? '',
      doctorName: json['doctorId']['name'] ?? '',
      doctorImageUrl: List<String>.from(json['doctorId']['images'] ?? []),
      slot: json['slot'] ?? '',
      status: json['status'] ?? '',
      reviewGiven: json['reviewGiven'] ?? false,
    );
  }
}
