

import 'package:fyp_patent/Features/Appointment/screen/Appointment_screen.dart';
//import 'package:app_final_fyp/Features/ChatBot/Screen/ChatBotScreem.dart';
import 'package:fyp_patent/Features/Search/Screen/search_screen.dart';
import 'package:flutter/material.dart';


import 'Features/Appointment/Ap12.dart';
import 'Features/Appointment/screen/Appoint.dart';
import 'Features/Auth/Screen/auth_screen.dart';

import 'Features/ChatBot/Screen/Chatbot.dart';
import 'Features/Chats/Screen/chatmenu.dart';
import 'Features/Info/Screen/CovidInfoScreen.dart';
import 'Features/Info/Screen/PneumoniaInfoScreen.dart';
import 'Features/Info/Screen/TbInfoScreen.dart';
import 'Features/Info/Screen/infoBox.dart';
import 'Features/home/screens/doctor_detail.dart';
import 'Features/home/screens/home_screens.dart';
import 'Features/home/screens/listOfDoctors.dart';

import 'Features/pnemonia/Screen/pnemonia.dart';
import 'Features/pnemonia/tb/screen/tb.dart';
import 'Features/prescription/screen/complete_p.dart';
import 'Features/prescription/screen/upcomming_p.dart';
import 'Features/user profile/Screen/patientEdit.dart';
import 'common/bottom_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>const AuthScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>const BottomBar());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>const HomeScreen());

    case ChatBot.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>const ChatBot());




    case InfoBoxScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=> InfoBoxScreen());


    case ListOfDoctors.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=> ListOfDoctors());

    case ChatMenu.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=> const ChatMenu());
    case MyHomePage.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>  MyHomePage());


    case Tb.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=>  Tb());




    case CovidInfoScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=> CovidInfoScreen());


    case TbInfoScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=> TbInfoScreen());


    case PneumoniaInfoScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_)=> PneumoniaInfoScreen());


    case BookAppointmentScreen.routeName:
      var doctorid=routeSettings.arguments as String;
      return MaterialPageRoute(

          settings: routeSettings,
          builder: (_)=> BookAppointmentScreen(doctorId: doctorid,));

    case SearchScreen.routeName:
      var SearchQuery=routeSettings.arguments as String;

      return MaterialPageRoute(

          settings: routeSettings,
          builder: (_)=> SearchScreen(
            SearchQuery:SearchQuery,
          ));

    case EditPatientScreen.routeName:
      var patientId=routeSettings.arguments as String;
      return MaterialPageRoute(

          settings: routeSettings,
          builder: (_)=> EditPatientScreen(patientId: patientId,));

    case DoctorDetailScreen.routeName:
      var args = routeSettings.arguments as Map<String, dynamic>; // Change this line
      var id = args['id'] as String;
      var name = args['name'] as String;
      var email = args['email'] as String;
      var password = args['password'] as String;
      var specialization = args['specialization'] as String;
      var gender = args['gender'] as String;
      var description = args['description'] as String;
      var phone = args['phone'] as String;
      var type = args['type'] as String;
      var medicalliecensenumber = args['medicalliecensenumber'] as String;
      var images = args['images'] as List<String>;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DoctorDetailScreen(
          id: id,
          name: name,
          email: email,
          password: password,
          specialization: specialization,
          gender: gender,
          description: description,
          phone: phone,
          type: type,
          images: images,
          medicalliecensenumber: medicalliecensenumber,

        ),
      );

    case UpcomingAppointments.routeName:
      var patientId=routeSettings.arguments as String;
      return MaterialPageRoute(

          settings: routeSettings,
          builder: (_)=> UpcomingAppointments( patientId: patientId,));


    case CompletedAppointments.routeName:
      var patientId=routeSettings.arguments as String;
      return MaterialPageRoute(

          settings: routeSettings,
          builder: (_)=> CompletedAppointments( patientId: patientId,));


    default:
      return MaterialPageRoute( settings: routeSettings,builder: (_)=>const Scaffold(
        body: Center(
          child: Text("Screen doesn't exist"),
        ),
      ));




  }
}