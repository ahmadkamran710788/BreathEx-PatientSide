import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../models/doctor.dart';
import '../services/home_services.dart';
import '../screens/doctor_detail.dart';

class RecentDoctor extends StatefulWidget {
  const RecentDoctor({Key? key}) : super(key: key);

  @override
  State<RecentDoctor> createState() => _RecentDoctorState();
}

class _RecentDoctorState extends State<RecentDoctor> {
  List<Doctor> doctors = []; // Declare as a non-nullable list
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchAllDoctors();
  }

  void fetchAllDoctors() async {
    final fetchedDoctors = await homeServices.fetchAllDoctor(context);
    setState(() {
      doctors = fetchedDoctors;
    });
  }

  void navigateToDetailPage({
    required String name,
    required String email,
    required String password,
    required String description,
    required List<String> images,
    required String phone,
    required String medicalliecensenumber,
    required String specialization,
    required String gender,
    required String type,
    String? id,
  }) {
    final arguments = {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'description': description,
      'images': images,
      'phone': phone,
      'medicalliecensenumber': medicalliecensenumber,
      'specialization': specialization,
      'gender': gender,
      'type': type,
    };

    Navigator.pushNamed(
      context,
      DoctorDetailScreen.routeName,
      arguments: arguments,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(doctors.length, (index) {
        final doctorData = doctors[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: GestureDetector(
            onTap: () => navigateToDetailPage(
              name: doctorData.name,
              email: doctorData.email,
              password: doctorData.password,
              description: doctorData.description,
              images: doctorData.images,
              phone: doctorData.phone,
              medicalliecensenumber: doctorData.medicalliecensenumber,
              specialization: doctorData.specialization,
              gender: doctorData.gender,
              type: doctorData.type,
              id: doctorData.id,
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(doctorData.images[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. ${doctorData.name}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(doctorData.specialization),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Ionicons.star,
                          color: Colors.yellow[700],
                          size: 18,
                        ),
                         Padding(
                          padding: EdgeInsets.only(left: 4, right: 6),
                          child: Text(
                            "${doctorData.star}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),

                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
