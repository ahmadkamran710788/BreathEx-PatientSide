import 'package:fyp_patent/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../home/screens/doctor_detail.dart';
class SearchDoctor extends StatelessWidget {
  final Doctor doctor;
  const SearchDoctor({Key? key,required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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


    return GestureDetector(
      onTap:  () => navigateToDetailPage(
      name: doctor.name,
      email: doctor.email,
      password: doctor.password,
      description: doctor.description,
      images: doctor.images,
      phone: doctor.phone,
      medicalliecensenumber: doctor.medicalliecensenumber,
      specialization: doctor.specialization,
      gender: doctor.gender,
      type: doctor.type,
      id: doctor.id,
    ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18,top: 10,left: 10),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(doctor.images[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. ${doctor.name}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(doctor.specialization),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Ionicons.star,
                        color: Colors.yellow[700],
                        size: 18,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4, right: 6),
                        child: Text(
                          "4.0",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text("195 Reviews")
                    ],
                  )
                ],
              )
            ],
          ),
      ),
    );
  }
}
