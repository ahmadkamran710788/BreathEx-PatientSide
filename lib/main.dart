import 'package:flutter/services.dart';
import 'package:fyp_patent/common/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fyp_patent/Features/home/screens/home_screens.dart';
import 'package:fyp_patent/Provider/patient_provider.dart';
import 'package:fyp_patent/router.dart';
import 'package:fyp_patent/Features/Appointment/screen/Appointment_screen.dart';
import 'package:fyp_patent/constrants/global_variables.dart';
import 'package:fyp_patent/Features/Auth/Screen/auth_screen.dart';
import 'package:fyp_patent/Features/Auth/Services/auth_services.dart';

import 'Features/Appointment/screen/Appoint.dart';
import 'Features/Auth/Screen/auth_screen.dart';
import 'Features/doctor/screen/profile.dart';
import 'Features/stripe/Screen/stipe_screen.dart';
import 'common/bottom_bar.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(


    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    authService.getUserData(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BreathEx',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<PatientProvider>(context)?.patient?.token?.isNotEmpty == true
          ? const BottomBar()
          :  const AuthScreen(),
    );
  }
}
