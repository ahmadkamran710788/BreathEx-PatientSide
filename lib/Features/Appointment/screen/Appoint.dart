import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constrants/global_variables.dart';

class AppointmentBooking extends StatefulWidget {
  static const routeName='/appointment-screen';
  const  AppointmentBooking({Key? key}) : super(key: key);

  //final String title;

  @override
  State<AppointmentBooking> createState() => _AppointmentBooking();
}

class _AppointmentBooking extends State<AppointmentBooking> {
  final Map<String, List<String>> availabilityData = {
    'Monday': ['0:29', '4:29'],
    'Tuesday': ['8:29'],
    'Wednesday': ['10:29'],
    'Thursday': ['8:29'],
    'Friday': ['12:29'],
    'Saturday': ['17:29'],
    'Sunday': [],
  };

  List<String> getAvailableSlots(String day) {
    return availabilityData[day] ?? [];
  }

  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  String _selectedDay = DateFormat('EEEE').format(DateTime.now());
  int _selectedSlotIndex = -1; // Initially no slot selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Booking"),//widget.title
      ),
      body: Center(
        child: SizedBox(
          width: 375,
          child: ListView(
            children: [
              _buildDefaultSingleDatePickerWithValue(),
            ],
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
      selectedDayHighlightColor: Colors.green,
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle:  const TextStyle(
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
                setState(() {
                  _selectedDay = DateFormat('EEEE').format(dates[0]!);
                  _selectedSlotIndex = -1;
                });
                setState(() => _singleDatePickerValueWithDefaultValue = dates);
              }),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Selection(s):  '),
              const SizedBox(width: 10),
              Text(
                _getValueText(
                  config.calendarType,
                  _singleDatePickerValueWithDefaultValue,
                ),
              ),
            ],
          ),
          const Divider(),
          const Text('Available Slots'),
          GridView.builder(
            shrinkWrap: true,
            itemCount: getAvailableSlots(_selectedDay).length,
            itemBuilder: (context, index) {
              final slots = getAvailableSlots(_selectedDay);
              final isSelected = index == _selectedSlotIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSlotIndex = index;
                  });
                },
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.brown,
                  color: isSelected ? Colors.green : Colors.white,
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
                    elevation: 8,
                    shadowColor: Colors.brown,

                    ),
                    onPressed: () {
                      final slots = availabilityData[_selectedDay];
                      String? slot = slots?[_selectedSlotIndex];
                      print(slot);
                      String date = _getValueText(
                        config.calendarType,
                        _singleDatePickerValueWithDefaultValue,
                      );
                      print(date);
                    },
                    child: const Text(
                      'Book Appointment',
                      style: TextStyle(fontSize: 20),
                    ),
                  )))
          ],);
    }
}