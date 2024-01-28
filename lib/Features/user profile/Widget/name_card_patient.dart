import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

import '../../../Provider/patient_provider.dart';

class NameCardPatient extends StatefulWidget {
  const NameCardPatient({Key? key}) : super(key: key);

  @override
  State<NameCardPatient> createState() => _NameCardPatientState();
}

class _NameCardPatientState extends State<NameCardPatient> {
  double value = 3.5;
  @override
  Widget build(BuildContext context) {
    final patient=Provider.of<PatientProvider>(context).patient;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.maxFinite,
        height: 160,
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                patient.images[0],
                width: 90,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    //name, email, password, phonenumber
                    patient.email.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 18),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
