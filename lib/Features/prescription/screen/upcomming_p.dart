import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/patient_provider.dart';
import '../../../constrants/utils.dart';
import '../../../models/appointment.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'complete_p.dart';

class UpcomingAppointments extends StatefulWidget {
  static const String routeName = '/upcomming-appointment2';
  const UpcomingAppointments({Key? key, required this.patientId})
      : super(key: key);
  final String patientId;
  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  late List<Appointment> appointments = [];
  bool showProgressBar = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppointments();
  }

  void getAppointments() async {
    setState(() {
      showProgressBar = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response response = await http.post(
      Uri.parse('$url/upcoming-appointment'),
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


  @override
  Widget build(BuildContext context) {
    final ahmad = Provider.of<PatientProvider>(context).patient;
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Appointments"),
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
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: Colors.green.withOpacity(0.8),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          radius: 30,
                          backgroundImage: NetworkImage(
                            appointments[index].doctorImageUrl?.isNotEmpty ==
                                    true
                                ? appointments[index].doctorImageUrl![0]
                                : '',
                          ),
                        ),
                        title: Text(
                          appointments[index].doctorName ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 3),
                                Text(appointments[index].date ?? ''),
                                const SizedBox(width: 10),
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 3),
                                Text(appointments[index].slot ?? ''),
                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  })),
    );
  }
}
