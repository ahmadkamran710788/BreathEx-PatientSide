import 'package:flutter/material.dart';

import '../../../common/custom buttons.dart';
import '../../../constrants/global_variables.dart';
import '../../Appointment/screen/Appoint.dart';
import '../widgets/name_card.dart';


class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Profile"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NameCard(),

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
                     children: [
                       Text(
                         "  Phone number",
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                           color: Colors.black,
                         ),
                       ),
                       Text("Number"),
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

                    children: [
                      Text("  Email :", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      )),
                      Text("Number"),
                    ],
                  ),

                  SizedBox(
                    height: 15,
                  ),


                  Column(
                    children: [
                      Text("  Gender :", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      )),
                      Text("Number"),
                    ],
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Text(
                    "Description ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text("Ahmad kamran"),
                  SizedBox(height: 15),

                  SizedBox(
                    height: 15,
                  ),



                ],
              ),
            ),
          ),
          SizedBox(height: 140,),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(text: "Book Appointment", onTap: (){
                Navigator.pushNamed(context, AppointmentBooking.routeName);
              })),
        ],
      ),
    );
  }
}
