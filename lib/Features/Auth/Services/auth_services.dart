import 'dart:convert';

import 'package:fyp_patent/Features/home/screens/home_screens.dart';
import 'package:fyp_patent/constrants/error_handling.dart';
import 'package:fyp_patent/constrants/utils.dart';
import 'package:fyp_patent/common/bottom_bar.dart';
import 'package:fyp_patent/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Provider/patient_provider.dart';
import '../Screen/auth_screen.dart';

class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phonenumber,
  }) async {
    try {
      Patient user = Patient(id: '', email: email, name: name, password: password, medicalhistory: '',images: [''], phonenumber: phonenumber, type: '', token: '');

      http.Response res = await http.post(
        Uri.parse('$url/api/signup') ,
        body: user.toJson() ,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          ssb(context, 'Account created! Login with the same');


        },
      );
    } catch (e) {
      ssb(context, e.toString());
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,

  }) async {
    try {


      http.Response res = await http.post(
        Uri.parse('$url/api/signin'),
        body: jsonEncode({
          'email':email,
          'password':password
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: ()async {
          ssb(context, 'Successful login');
          //shared perferences
          SharedPreferences prefs= await SharedPreferences.getInstance();
          Provider.of<PatientProvider>(context,listen: false).SetPatient(res.body);
          await prefs.setString("x-auth-token", jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(context,BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      ssb(context, e.toString());
    }
  }

  Future<void> getUserData(
      BuildContext context,


      ) async {
    final userProvider = Provider.of<PatientProvider>(context, listen: false);
    try {
      SharedPreferences pref=await SharedPreferences.getInstance();
      String? token= pref.getString('x-auth-token');
      if(token ==null ||token.isEmpty ){
        pref.setString('x-auth-token', '');
      }
      var tokenRes= await http.post(Uri.parse('$url/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8','x-auth-token':token!
        },);
      var response=jsonDecode(tokenRes.body);

      if(tokenRes.statusCode==200){
        //get the user data
        http.Response userRes=await http.get(Uri.parse('$url/'),headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8','x-auth-token':token!
        },);
        if(userRes.statusCode==200){
          var userProvider=Provider.of<PatientProvider>(context,listen: false);
          userProvider.SetPatient(userRes.body);
        }

      }else{
        print("not working");
      }

    } catch (e) {
      ssb(context, e.toString());
    }
  }


  void logOut(BuildContext context) async {
    try{
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeName, (route) => false,);


    }
    catch(e){
      ssb(context, e.toString());

    }
  }




}



