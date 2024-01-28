import 'package:fyp_patent/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';




class PatientProvider extends ChangeNotifier{
  Patient _patient= Patient(id: '', email: '', name: '', password: '',images: [''], medicalhistory: '', phonenumber: '', type: '', token: '');

  Patient get patient=>_patient;

  void SetPatient(String patient){
    _patient =Patient.fromJson(patient);
    notifyListeners();


  }

}