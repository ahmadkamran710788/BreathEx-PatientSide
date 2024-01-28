import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart' ;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../../Provider/patient_provider.dart';
import '../../../common/custom buttons.dart';
import '../../../constrants/utils.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = '/pnemonia-1';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? body;
  File? _file;
  List<int>? imageBytes;

  Future<void> uploadImage() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (myfile == null) {
      // User canceled the image picking
      return;
    }

    setState(() {
      print("sss");
      _file = File(myfile.path);
      imageBytes = _file!.readAsBytesSync();
    });
  }

  Future<void> predict() async {
    if (_file == null) {

      return;
    }

    String base64 = base64Encode(_file!.readAsBytesSync());
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.put(
      Uri.parse("$url2/"),
      body: base64,
      headers: requestHeaders,
    );
    print(response.body);
    setState(() {
      body = response.body;
    });
    _showReportDialog(context);
  }
  Future<void> generateReport(BuildContext context) async {
    final patient = Provider.of<PatientProvider>(context, listen: false).patient;

    if (imageBytes == null) {
      // Handle the case where imageBytes is null
      return;
    }

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        final pdf = pw.Document();

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                children: [
                  pw.Row(
                    children: [
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Name: ${patient.name}"),
                          pw.Text("Email: ${patient.email}"),
                          pw.Text("ID: ${patient.id}"),
                          pw.Text("Phone Number: ${patient.phonenumber}"),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  // Ensure imageBytes is not null before using it
                  pw.Image(pw.MemoryImage(Uint8List.fromList(imageBytes!))),
                  pw.SizedBox(height: 20),
                  pw.Center(child: pw.Text("Status : ${body ?? ""}",style: pw.TextStyle(fontSize: 20)))
                ],
              );
            },
          ),
        );
        return pdf.save();
      },
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Prediction Result'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Status: ${body ?? ""}'),
                // Add more information from the response or any other relevant data
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                print("ahmad");
                generateReport(context);
              },
              child: Text('Report'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pneumonia"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _file == null
                ? Text("Image not found")
                : Image.file(_file!),

            Text("Status :${body ?? ""}"), // Provide a default value if body is null

            SizedBox(height: 90,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(text: "Upload Image", onTap: (){uploadImage();})),
            SizedBox(height: 10,),


            _file != null
                ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                text: "Predict",
                onTap: () {
                  if (_file != null) {
                    predict();
                  }
                },
              ),
            )
                : Text(""),


          ],
        ),
      ),
    );
  }
}
