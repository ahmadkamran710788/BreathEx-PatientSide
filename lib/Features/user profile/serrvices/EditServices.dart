import 'dart:convert';
import 'dart:io';




import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../../../common/bottom_bar.dart';

import '../../../constrants/error_handling.dart';
import '../../../constrants/utils.dart';

class ProfileService{


  void editDoctor({
    required BuildContext context,
    required String name,


    required String phone,
    required String? id,
  }) async {
    print("ak47");

    try {


      // Construct the request payload as a Map
      Map<String, dynamic> requestBody = {
        'id': id,
         // Use the generated image URLs

        'name': name,
        'phone': phone
      };

      http.Response res = await http.put(
        Uri.parse('$url/edit-profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          ssb(context, "Successfully Edited");
        },
      );
      Navigator.pop(context);
    } catch (e) {
      ssb(context, e.toString());
    }
  }



















}