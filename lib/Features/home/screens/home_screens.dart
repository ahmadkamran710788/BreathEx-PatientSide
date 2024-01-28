import 'package:fyp_patent/Features/Search/Screen/search_screen.dart';
import 'package:fyp_patent/Features/home/widgets/health_need.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../Provider/patient_provider.dart';
import '../widgets/first_card.dart';
import '../widgets/list_recent_doctors.dart';
import 'listOfDoctors.dart';

class HomeScreen extends StatefulWidget {

  static const String routeName='home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  void NavigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments:query );
  }


  @override
  Widget build(BuildContext context) {
    final patient=Provider.of<PatientProvider>(context).patient;
    final patient_name=patient.name;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi, $patient_name",style: TextStyle(color: Colors.black),),
            Text(
              "How are you feeling today?",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.notifications_outline,color: Colors.black,),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
            icon: _isSearching
                ? Icon(
              Ionicons.close_outline,
              color: Colors.black,
            )
                : Icon(
              Ionicons.search_outline,
              color: Colors.black,
            ),
          ),
        ],
        bottom: _isSearching
            ? PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:TextFormField(
              onFieldSubmitted: NavigateToSearchScreen,
              decoration: InputDecoration(
                  prefixIcon: InkWell(
                    onTap: (){},
                    child: const Padding(padding: EdgeInsets.only(
                      left: 6,
                    ),
                      child:const  Icon(Icons.search,color: Colors.black,size: 23,),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(top: 10),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7),),
                      borderSide: BorderSide.none
                  ),
                  enabledBorder: const  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide(color: Colors.black38,width: 1)
                  ),
                  hintText: 'Search ',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,fontSize: 17
                  )

              ),
            )
          ),
        )
            : null,
      ),

      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(14),
        children: [
          const AppointmentCard(),
          const SizedBox(height: 20),
          Text(
            "Health Needs",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15),
          const HealthNeeds(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Doctor's List ",style: TextStyle(fontSize: 20),),
              TextButton(onPressed: (){Navigator.pushNamed(context, ListOfDoctors.routeName);}, child: Text("See all doctors",style: TextStyle(fontSize: 10)))
            ],
          ),
          const RecentDoctor()

        ],
      ),
    );
  }
}
