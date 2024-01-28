import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String url='http://192.168.43.29:9000/BreathEx';
String url2="http://192.168.43.29:5000";

void ssb(BuildContext context ,String text){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text))

  );
}

Future<List<File>> pickImages() async {
  List<File>images=[];
  try{
    FilePickerResult? files=await FilePicker.platform.pickFiles(type: FileType.custom,allowMultiple:true,);

    if(files!=null && files.files.isNotEmpty){
      for(int i =0;i<files.files.length;i++){
        images.add(File(files.files[i].path!));
      }
    }
  }catch(e){
    debugPrint(e.toString());
  }
  return images;
}