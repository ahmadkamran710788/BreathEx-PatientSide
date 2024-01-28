import 'package:fyp_patent/Features/Auth/Services/auth_services.dart';
import 'package:fyp_patent/Features/user%20profile/Screen/patientEdit.dart';
import 'package:fyp_patent/Features/user%20profile/Widget/name_card_patient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/patient_provider.dart';
import '../../../common/custom buttons.dart';
import '../../../constrants/global_variables.dart';
import '../../home/screens/listOfDoctors.dart';




class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {

  final AuthService authService=AuthService();

  void NavigateToEditScreen( {String? patientId}){
    Navigator.pushNamed(context, EditPatientScreen.routeName,arguments:patientId  );
  }


  @override
  Widget build(BuildContext context) {

    final patient=Provider.of<PatientProvider>(context).patient;
    final String name=patient.name.toString();
    return Scaffold(
      appBar: AppBar(title: Text("$name  Profile"),actions: [IconButton(icon: Icon(Icons.edit),tooltip: 'Edit profile',onPressed: (){NavigateToEditScreen(patientId:patient.id);},color: Colors.white,),SizedBox(width: 10,)],backgroundColor: Colors.green,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NameCardPatient(),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.grey.shade300,
              ),


              child:  Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone number",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          Text(patient.phonenumber.toString()),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: Container(

                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),

                              ),
                              color: Colors.green,
                            ),
                            child:Icon(Icons.add,size: 20,color: Colors.black,)
                        ),
                      )

                    ],
                  ),

                  SizedBox(
                    height: 5,
                  ),




                  Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email :", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      )),
                      Text(patient.email),
                    ],
                  ),

                  SizedBox(
                    height: 15,
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 90,),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(text: "Book Appointment", onTap: (){Navigator.pushNamed(context,ListOfDoctors.routeName );})),
          SizedBox(height: 10,),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(text: "Signout", onTap: (){
                authService.logOut(context);
              })),
        ],
      ),
    );
  }
}
