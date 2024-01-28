
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:fyp_patent/constrants/global_variables.dart';
import 'package:fyp_patent/constrants/utils.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Provider/patient_provider.dart';




class BookAppointmentScreen extends StatefulWidget {
  static const String routeName='booking-screen';
  BookAppointmentScreen({Key? key, required this.doctorId}) : super(key: key);

  String doctorId;


  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {

  List<dynamic> availableSlots = [];

  @override
  initState() {
    super.initState();
    getSlots(DateTime.now().toString());
  }

  void getSlots(String date) async {


    http.Response response = await http.post(
        Uri.parse(
            '$url/get-available-slots'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',

        },
        body: jsonEncode({      "date": date,
          "doctorId": widget.doctorId
        }));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        availableSlots = jsonResponse['availableSlots'];
      });
      print(availableSlots);
    }
  }

  Future<bool> bookAppointment(String date, String slot) async {
  final patient=Provider.of<PatientProvider>(context,listen: false);



    http.Response response = await http.post(
        Uri.parse('$url/book-appointment'),
        body: jsonEncode({
          "patientId":patient.patient.id,
            "doctorId": widget.doctorId,
          "date": date,
          "slot": slot}),
        headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',

    });


    return response.statusCode == 200;
  }


  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  int _selectedSlotIndex = -1; // Initially no slot selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Appointment',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.brown,
              fontSize: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              size: 35,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 375,
            child: ListView(
              children: [
                _buildDefaultSingleDatePickerWithValue(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
      ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: GlobalVariables.secondaryColor,
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: GlobalVariables.secondaryColor,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        CalendarDatePicker2(
            config: config,
            value: _singleDatePickerValueWithDefaultValue,
            onValueChanged: (dates) {
              getSlots(dates[0]!.toString());
              setState(() {
                _selectedSlotIndex = -1;
              });
              setState(() => _singleDatePickerValueWithDefaultValue = dates);
            }),
        const SizedBox(height: 10),
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     const Text('Selection(s):  '),
        //     const SizedBox(width: 10),
        //     Text(
        //       _getValueText(
        //         config.calendarType,
        //         _singleDatePickerValueWithDefaultValue,
        //       ),
        //     ),
        //   ],
        // ),
        const Divider(),
        const Text('Available Slots', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 20),),
        GridView.builder(
          shrinkWrap: true,
          itemCount: availableSlots.length,
          itemBuilder: (context, index) {
            final slots = availableSlots;
            final isSelected = index == _selectedSlotIndex;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSlotIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: isSelected ? GlobalVariables.secondaryColor : Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      slots[index],
                      style: TextStyle(
                        fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 2),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
                height: 50,
                width: 500,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.secondaryColor),
                  onPressed: () async {
                    String? slot = availableSlots[_selectedSlotIndex];
                    String date = _getValueText(
                      config.calendarType,
                      _singleDatePickerValueWithDefaultValue,
                    );

                    Future<bool> res   = bookAppointment( date,slot!);
                    if (await res) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          content: Text(
                              'Appointment Booked!')));
                          Navigator.pop(context);
                      // Navigator.push(
                      //     context,
                          // MaterialPageRoute(
                          //     builder: (context) =>
                          //     const HomeScreen()));
                    }
                    else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          content: Text(
                              'Ooops,you have booked this slot appointment!')));
                    }
                  },
                  child: const Text(
                    'Book Appointment',
                    style: TextStyle(fontSize: 20,color: Colors.black),
                  ),
                )))
      ],
    );
  }
}