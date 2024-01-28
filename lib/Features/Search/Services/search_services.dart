import 'dart:convert';

import 'package:fyp_patent/Provider/patient_provider.dart';
import 'package:fyp_patent/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constrants/error_handling.dart';
import '../../../constrants/utils.dart';

class SearchServices {
  Future<List<Doctor>> fetchSearchedDoctor({
    required BuildContext context,
    required String SearchQuery,
  }) async {
    final userProvider = Provider.of<PatientProvider>(context, listen: false);
    List<Doctor> doctorList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$url/api/doctor/search/$SearchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.patient.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            doctorList.add(
              Doctor.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      ssb(context, e.toString());
    }
    return doctorList;
  }


}