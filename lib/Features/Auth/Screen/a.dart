import 'package:flutter/material.dart';

import '../../../Provider/patient_provider.dart';
import 'package:provider/provider.dart';
class ahmad extends StatefulWidget {

  const ahmad({Key? key}) : super(key: key);

  @override
  State<ahmad> createState() => _ahmadState();
}

class _ahmadState extends State<ahmad> {
  @override

  Widget build(BuildContext context) {
    final patient = Provider.of<PatientProvider>(context).patient;
    final patient_name = patient.name;
    return Container();
  }
}
