import 'package:fyp_patent/constrants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../Features/Chats/Screen/chatmenu.dart';
import '../Features/Info/Screen/infoBox.dart';
import '../Features/home/screens/home_screens.dart';
import '../Features/home/screens/listOfDoctors.dart';
import '../Features/user profile/Screen/patient_profile.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomNavigationBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const ListOfDoctors(),
      InfoBoxScreen(),
     const PatientProfile()

  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //home page
          BottomNavigationBarItem(
            icon: Container(
                width: bottomNavigationBarWidth,

                child: const Icon(Ionicons.home_outline)
            ),
            activeIcon: Icon(Ionicons.home),
            label: "",
          ),
          //Account
          BottomNavigationBarItem(
            icon: Container(
                width: bottomNavigationBarWidth,

                child: const Icon(Ionicons.calendar_outline)),
            activeIcon: Icon(Ionicons.calendar),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavigationBarWidth,

              child: const Icon(Ionicons.information_outline),
            ),
            activeIcon: Icon(Ionicons.information),
            label: "",
          ),
          //chat
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavigationBarWidth,

              child: const Icon(Ionicons.person_outline),
            ),
          activeIcon: Icon(Ionicons.person),
            label: "",
          ),
        ],
      ),
    );
  }
}
