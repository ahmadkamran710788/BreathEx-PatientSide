import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

import '../../../Provider/patient_provider.dart';
import '../../../constrants/error_handling.dart';
import '../../../constrants/utils.dart';

class AppointmentServices {
  final Function(List<String>) updateAvailableSlots;

  AppointmentServices({required this.updateAvailableSlots});

  Future<void> getSlots({
    required BuildContext context,
    required String date,
    required String doctorId,
  }) async {
    try {
      final userProvider = Provider.of<PatientProvider>(context, listen: false);
      final response = await http.post(
        Uri.parse('$url/get-available-slots'),
        body: jsonEncode({
          'date': date,
          'doctor': doctorId,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.patient.token,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        updateAvailableSlots(jsonResponse['availableSlots']);
        // You may use a logging library here instead of print.
        // logger.d(jsonResponse['availableSlots']);
      }
      else {
         throw Exception('Failed to load slots');
       }
    } catch (e) {
      ssb(context, e.toString());
    }
  }

  Future<bool> bookAppointment(String date, String slot, BuildContext context) async {
    final userProvider = Provider.of<PatientProvider>(context, listen: false);

    try {
      final response = await http.post(
        Uri.parse('$url/book-appointment'),
        body: jsonEncode({
          'date': date,
          'slot': slot,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.patient.token,
        },
      );

      if (response.statusCode == 200) {
        ssb(context, 'Appointment Booked!');
        Navigator.pop(context);
        return true;
      } else {
        throw Exception('Failed to book appointment');
      }
    } catch (e) {
      ssb(context, e.toString());
      return false;
    }
  }
}
