//
 import 'package:fyp_patent/Features/home/widgets/single_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../Provider/patient_provider.dart';

import '../../ChatBot/Screen/Chatbot.dart';
import '../../pnemonia/Screen/pnemonia.dart';
import '../../pnemonia/tb/screen/tb.dart';
import '../../prescription/screen/upcomming_p.dart';
import '../screens/listOfDoctors.dart';
import 'health_need.dart';
import 'health_need.dart';


import '../../Info/Screen/infoBox.dart';

class HealthNeeds extends StatelessWidget {
  const HealthNeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ahmad=Provider.of<PatientProvider>(context).patient;

    List<CustomIcon> customIcons = [
      CustomIcon(name: "Appointment", icon: 'assets/appointment.png'),
      CustomIcon(name: "Reminder", icon: 'assets/md1.jpg'),
      CustomIcon(name: "Covid-19", icon: 'assets/virus.png'),
      CustomIcon(name: "ChatBot", icon: 'assets/robort.jpg'),
      CustomIcon(name: "More", icon: 'assets/more.png'),
    ];
    List<CustomIcon> healthNeeds = [
      CustomIcon(name: "Appointment", icon: 'assets/appointment.png'),
      CustomIcon(name: "Prescription", icon: 'assets/threed.png'),
      CustomIcon(name: "Info", icon: 'assets/blood.png'),
      CustomIcon(name: "ChatBot", icon: 'assets/robort.jpg'),

    CustomIcon(name: "Reminder", icon: 'assets/md1.jpg'),
    ];
    List<CustomIcon> Detection = [
      CustomIcon(name: "Covid-19", icon: 'assets/virus.png'),
      CustomIcon(name: "TB", icon: 'assets/tb.jpg'),
      CustomIcon(name: "Pneumonia", icon: 'assets/pn.jpg'),


    ];

    return  Container(
      height: 100,
      width: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HealthNeedSingleCard(text: customIcons[0].name, onTap: () {Navigator.pushNamed(context,ListOfDoctors.routeName );}, path: customIcons[0].icon),
         SizedBox(width: 10,),
          //HealthNeedSingleCard(text: customIcons[1].name, onTap: () {}, path: customIcons[1].icon),
          HealthNeedSingleCard(text: Detection[2].name, onTap: () {
            Navigator.pushNamed(context, MyHomePage.routeName);
          }, path: Detection[2].icon),
          SizedBox(width: 10,),
          // HealthNeedSingleCard(text: customIcons[2].name, onTap: () {}, path: customIcons[2].icon),
          HealthNeedSingleCard(text: healthNeeds[1].name, onTap: () {
            Navigator.pushNamed(context, UpcomingAppointments.routeName,arguments:ahmad.id

            );
          }, path: healthNeeds[1].icon),
          SizedBox(width: 10,),
          HealthNeedSingleCard(text: customIcons[3].name, onTap: () {Navigator.pushNamed(context, ChatBot.routeName);}, path: customIcons[3].icon),
          SizedBox(width: 10,),
          HealthNeedSingleCard(text: customIcons[4].name, onTap: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (context) {
                return Column(

                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(right: 20.0,left: 20.0),
                      child: Row(
                        children: [
                          HealthNeedSingleCard(text: healthNeeds[4].name, onTap: () {}, path: healthNeeds[4].icon),
                          SizedBox(width: 7),
                          // HealthNeedSingleCard(text: Detection[0].name, onTap: () {}, path: Detection[0].icon),
                          HealthNeedSingleCard(text: healthNeeds[3].name, onTap: () {Navigator.pushNamed(context, ChatBot.routeName);}, path: healthNeeds[3].icon),
                          SizedBox(width: 7),
                          HealthNeedSingleCard(text: Detection[1].name, onTap: () {
                            Navigator.pushNamed(context, Tb.routeName);
                          }, path: Detection[1].icon),
                          SizedBox(width: 7),
                          HealthNeedSingleCard(text: Detection[2].name, onTap: () {
                            Navigator.pushNamed(context, MyHomePage.routeName);
                          }, path: Detection[2].icon),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0,left: 20.0),
                      child: Row(
                        children: [
                          HealthNeedSingleCard(text: healthNeeds[0].name, onTap: () {Navigator.pushNamed(context,ListOfDoctors.routeName );}, path: healthNeeds[0].icon),
                          SizedBox(width: 3),
                          HealthNeedSingleCard(text: healthNeeds[1].name, onTap: () {
                            Navigator.pushNamed(context, UpcomingAppointments.routeName,arguments:ahmad.id

                            );
                          }, path: healthNeeds[1].icon),
                          SizedBox(width: 3),
                          HealthNeedSingleCard(text: healthNeeds[2].name, onTap: () {Navigator.pushNamed(context, InfoBoxScreen.routeName);}, path: healthNeeds[2].icon),
                          SizedBox(width: 3),

                        ],
                      ),
                    ),
                  ],
                );
              },
            );

          }, path: customIcons[4].icon),
        ],
      ),
    );
  }
}

class CustomIcon {
  final String name;
  final String icon;

  CustomIcon({
    required this.name,
    required this.icon,
  });
}

