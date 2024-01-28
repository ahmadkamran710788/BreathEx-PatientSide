
import 'package:flutter/material.dart';

import '../constrants/global_variables.dart';


class CustomTextFeld extends StatelessWidget {
  final TextEditingController controller;
  final  String hintText;
  const CustomTextFeld({Key? key,required this.controller,required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: GlobalVariables.greyBackgroundCOlor),)
        ,
      ),
      child:  TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none
        ),

      validator: (val){
        if(val==null || val.isEmpty){
          return 'Enter your $hintText';
        }
        return null;
      },


      ),

    );
  }
}
//controller: controller,
// validator: (val){
// if(val==null || val.isEmpty){
// return 'Enter your $hintText';
// }
// return null;
// },
