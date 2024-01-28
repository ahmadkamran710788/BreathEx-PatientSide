// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:async';
//
// class AddMedicationScreen extends StatefulWidget {
//   const AddMedicationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddMedicationScreen> createState() => _AddMedicationScreenState();
// }
//
// class _AddMedicationScreenState extends State<AddMedicationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _medicineNameController = TextEditingController();
//   final _dosageController = TextEditingController();
//   String _selectedMedicineType = 'Bottle';
//   final _intervalController = TextEditingController();
//   final _dateTimeController = TextEditingController();
//   final values = List.filled(7, true);
//
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//
//     var initializationSettingsAndroid =
//     const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid);
//
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: SafeArea(
//               minimum: const EdgeInsets.all(16),
//               child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Medicine Name *',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       TextFormField(
//                         controller: _medicineNameController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the medicine name';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         'Dosage (mg) *',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       TextFormField(
//                         controller: _dosageController,
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the dosage';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         'Medicine Type *',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       DropdownButtonFormField<String>(
//                         value: _selectedMedicineType,
//                         items: ['Bottle', 'Pill', 'Syringe', 'Tablet']
//                             .map((type) => DropdownMenuItem<String>(
//                           value: type,
//                           child: Text(type),
//                         ))
//                             .toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedMedicineType = value!;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         'Medication Interval (hours) *',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       TextFormField(
//                         controller: _intervalController,
//                         keyboardType:
//                         TextInputType.number, // Allow only numeric input
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           _IntervalInputFormatter(),
//                         ], // Allow only digits
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the medication interval';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         'Starting time *',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       TextFormField(
//                         controller: _dateTimeController,
//                         onTap: () {
//                           _selectDateTime(context);
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the starting time';
//                           }
//                           return null;
//                         },
//                         readOnly:
//                         true, // Make it read-only to prevent manual input
//                       ),
//                       const SizedBox(height: 16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           OutlinedButton(
//                             onPressed: () {
//                               // Perform cancel actions
//                               _stopNotifications();
//                               // Navigator.pop(context);
//                             },
//                             child: const Text('Cancel'),
//                           ),
//                           const SizedBox(width: 16),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Theme.of(context)
//                                     .colorScheme
//                                     .inversePrimary),
//                             onPressed: () {
//                               if (_formKey.currentState?.validate() ?? false) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text('Form submitted')),
//                                 );
//                               }
//                             },
//                             child: const Text(
//                               'Submit',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ))),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _selectDateTime(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)), // Allow selection for one year
//     );
//
//     if (picked != null) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//
//       if (pickedTime != null) {
//         final DateTime selectedDateTime = DateTime(
//           picked.year,
//           picked.month,
//           picked.day,
//           pickedTime.hour,
//           pickedTime.minute,
//         );
//
//         // Check if the selected time is in the future
//         if (selectedDateTime.isAfter(DateTime.now())) {
//           _dateTimeController.text = selectedDateTime.toString();
//
//           // Calculate the delay until the starting time
//           final delay = selectedDateTime.difference(DateTime.now());
//
//           // Schedule periodic notifications
//           scheduleNotifications(delay);
//         } else {
//           // Show an error message or handle the case where the selected time is not in the future
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Please select a future starting time'),
//             ),
//           );
//         }
//       }
//     }
//   }
//
//   void scheduleNotifications(Duration delay) {
//     final interval = int.parse(_intervalController.text); // Interval in hours
//
//     Timer(delay, () {
//       Timer.periodic(Duration(hours: interval), (Timer timer) {
//         _showNotification();
//       });
//     });
//   }
//
//
//   Future<void> _showNotification() async {
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       'your_channel_id',
//       'DermaAid',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Hello',
//       'It\'s time to take your medication!',
//       platformChannelSpecifics,
//       payload: 'Default_Sound',
//     );
//   }
//
//   Future<void> _stopNotifications() async {
//     flutterLocalNotificationsPlugin.cancelAll();
//   }
//
// }
//
// class _IntervalInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue,
//       TextEditingValue newValue,
//       ) {
//     // Allow only whole numbers
//     if (newValue.text.contains('.') || newValue.text.contains(',')) {
//       return oldValue;
//     }
//     return newValue;
//   }
// }
//
// // WeekdaySelector(
// // onChanged: (int day) {
// // setState(() {
// // // Use module % 7 as Sunday's index in the array is 0 and
// // // DateTime.sunday constant integer value is 7.
// // final index = day % 7;
// // values[index] = !values[index];
// // });
// // },
// // values: values,
// // )