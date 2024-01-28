import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/bottom_bar.dart';
import '../../../constrants/error_handling.dart';
import '../../../constrants/utils.dart';
import '../../../models/appointment.dart';

class CompletedAppointments extends StatefulWidget {
  static const String routeName = '/complete-appointment2';

  const CompletedAppointments({Key? key, required this.patientId})
      : super(key: key);
  final String patientId;


  @override
  State<CompletedAppointments> createState() => _CompletedAppointmentsState();
}

class _CompletedAppointmentsState extends State<CompletedAppointments> {
  late List<Appointment> appointments = [];
  List<dynamic> prescriptions = [];
  double value = 1;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingControllerComment =
  TextEditingController();
  bool showProgressBar = false;

  @override
  void initState() {
    super.initState();
    getAppointments();
  }

  void getAppointments() async {
    setState(() {
      showProgressBar = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokenUser') ?? '';

    http.Response response = await http.post(
      Uri.parse('$url/completed-appointment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'patientId': widget.patientId}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        appointments = jsonResponse
            .map<Appointment>((json) => Appointment.fromJson(json))
            .toList();
      });
    }
    setState(() {
      showProgressBar = false;
    });
  }

  void getPrescription(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokenUser') ?? '';

    http.Response response = await http.get(
        Uri.parse('$url/get-prescription/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        prescriptions = jsonResponse['prescription'];
      });
    }
  }

  Future<void> postComment(String apptId, String patId, String docId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokenUser') ?? '';
    var reqBody = {
      "patient": patId,
      "doctor": docId,
      "appointment": apptId,
      "stars": value.toString(),
      "content": _textEditingControllerComment.text
    };
    http.Response response = await http.post(
      Uri.parse('$url/add-comment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(reqBody), // Update this line
    );
    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: ()async {
          Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
          ssb(context, 'Successful added');});

  }
  void getStars(String docId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokenDoc') ?? '';


    http.Response response = await http.get(
      Uri.parse('$url/doctor/$docId/average-rating'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Appointments"),
        centerTitle: true,
        backgroundColor: Colors.green.withOpacity(0.8),
        actions: [
          IconButton(
            onPressed: () {
              //Navigator.pushNamed(context, CompleteAppointments.routeName,arguments:widget.doctorId
              Navigator.pushNamed(context, CompletedAppointments.routeName,
                  arguments: widget.patientId);


            },
            icon: Icon(Icons.check_circle),
            tooltip:
            "Complete Appointments", // Replace 'icon1' with the desired icon
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: showProgressBar
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: appointments.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor:
                Colors.green.withOpacity(0.8),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  NetworkImage(appointments[index].doctorImageUrl[0]),
                ),
                title: Text(
                  appointments[index].doctorName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_month,
                            color: Colors.white),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          appointments[index].date,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.access_time,
                            color: Colors.white),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          appointments[index].slot,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment:
                      !appointments[index].reviewGiven
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8), // Adjust button size
                            backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                          ),
                          onPressed: () {
                            getPrescription(appointments[index].id);
                            Future.delayed(const Duration(seconds: 1), () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  builder: (BuildContext context) {
                                    return Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: IconButton(
                                              icon: const Icon(Icons.cancel),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )),
                                        Container(
                                          height: 300,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight: Radius.circular(25))),
                                          child: ListView.builder(
                                              itemCount: prescriptions.length,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: ListTile(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    tileColor: Theme.of(context).colorScheme.inversePrimary,
                                                    title: Text(
                                                      prescriptions[index]['medicineName'],
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                            'Duration: ${prescriptions[index]['duration']} days',
                                                            style: const TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                        Text(
                                                            'Dosage (per day): ${prescriptions[index]['dosage']}',
                                                            style: const TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                        Text(
                                                            'Directions: ${prescriptions[index]['directions']}',
                                                            style: const TextStyle(
                                                              fontSize: 15,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    );
                                  });
                            });
                          },
                          child: const Text(
                            'Prescription',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (!appointments[index].reviewGiven)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8), // Adjust button size
                                backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                              ),
                              onPressed: () {
                                showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 500,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25))),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: IconButton(
                                                  icon: const Icon(Icons.cancel),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: RatingStars(
                                                value: value,
                                                onValueChanged: (v) {
                                                  setState(() {
                                                    value = v;
                                                  });
                                                },
                                                starBuilder: (index, color) => Icon(
                                                  Icons.star,
                                                  color: color,
                                                ),
                                                starCount: 5,
                                                starSize: 20,
                                                maxValue: 5,
                                                starSpacing: 2,
                                                maxValueVisibility: true,
                                                valueLabelVisibility: false,
                                                animationDuration: const Duration(milliseconds: 1000),
                                                valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                                valueLabelMargin: const EdgeInsets.only(right: 8),
                                                starOffColor: const Color(0xffe7e8ea),
                                                starColor: Colors.green.withOpacity(0.8),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Form(
                                                key: _formKey,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          vertical: 8, horizontal: 8),
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.multiline,
                                                        maxLines: 7,
                                                        controller: _textEditingControllerComment,
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return "Comment field cannot be empty!";
                                                          }
                                                          return null;
                                                        },
                                                        decoration: const InputDecoration(
                                                          hintText: 'Write Comment...',
                                                          filled: true,
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          vertical: 8, horizontal: 8),
                                                      child: SizedBox(
                                                        height: 50,
                                                        width: 500,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: 12, vertical: 8), // Adjust button size
                                                            backgroundColor:
                                                            Theme.of(context).colorScheme.inversePrimary,
                                                          ),
                                                          onPressed: () async {
                                                            if (_formKey.currentState!.validate()) {
                                                              Future<void> res = postComment(
                                                                  appointments[index].id,
                                                                  appointments[index].patientId,
                                                                  appointments[index].doctorId);
                                                              print("ahmad");
                                                              getStars(appointments[index].doctorId);

                                                            }
                                                          },
                                                          child: const Text(
                                                            'Submit',
                                                            style: TextStyle(fontSize: 16), // Adjust text size if needed
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: const Text(
                                'Give Review',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
