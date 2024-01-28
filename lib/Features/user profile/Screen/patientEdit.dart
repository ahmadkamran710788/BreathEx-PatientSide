import 'dart:io';


import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../common/custom buttons.dart';
import '../../../common/custom_text_field_form.dart';
import '../../../constrants/global_variables.dart';
import '../../../constrants/utils.dart';
import '../serrvices/EditServices.dart';


class EditPatientScreen extends StatefulWidget {
  static const String routeName = '/add-doctors';
  const EditPatientScreen({Key? key,required  this.patientId}) : super(key: key);
    final String? patientId;
  @override
  State<EditPatientScreen> createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {

  final TextEditingController _patientController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  final ProfileService editServices=ProfileService();

  List<File> images = [];
  final _editPatientFormKey=GlobalKey<FormState>();
  @override
  void dispose() {
    _patientController.dispose();
    _phoneController.dispose();



    // TODO: implement dispose
    super.dispose();
  }


  void EditPatient(){
    if(_editPatientFormKey.currentState!.validate()){
      editServices.editDoctor(context: context, name: _patientController.text,  phone: _phoneController.text, id: widget.patientId);
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          //humen yaha per linear gradiate chahye iss waja se app bar asi hai
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: const Text(
            "Edit Patient",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _editPatientFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 30,
                ),
                CustomTextFeld1(controller: _patientController, hintText: "Patient Name"),
                SizedBox(
                  height: 10,
                ),

                CustomTextFeld1(controller: _phoneController, hintText: "Patient Phone"),

                SizedBox(
                  height: 10,
                ),

                CustomButton(text: "Edit", onTap:(){

                  if(_editPatientFormKey.currentState!.validate()){
                    print(widget.patientId);

                    editServices.editDoctor(context: context, name: _patientController.text, phone: _phoneController.text, id: widget.patientId);
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
