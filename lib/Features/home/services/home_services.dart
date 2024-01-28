import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../Provider/patient_provider.dart';
import '../../../constrants/error_handling.dart';
import '../../../constrants/utils.dart';
import '../../../models/doctor.dart';
import 'package:http/http.dart' as http;

class HomeServices{
  Future<List<Doctor>> fetchAllDoctor(BuildContext context) async {
    final userProvider = Provider.of<PatientProvider>(context,listen: false );
    List<Doctor> doctorList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$url/get-doctors'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.patient.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            doctorList.add(
              Doctor.fromJson(
                jsonEncode(jsonDecode(res.body)[i])
                ,

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