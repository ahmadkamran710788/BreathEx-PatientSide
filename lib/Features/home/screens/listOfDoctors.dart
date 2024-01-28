import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ionicons/ionicons.dart';


import '../../../Provider/patient_provider.dart';
import '../../../models/doctor.dart';
import '../../Search/Screen/search_screen.dart';
import '../services/home_services.dart';
import 'doctor_detail.dart';

class ListOfDoctors extends StatefulWidget {
  static const String routeName='doctor-list-screen';
  const ListOfDoctors({Key? key}) : super(key: key);

  @override
  _ListOfDoctorsState createState() => _ListOfDoctorsState();
}

class _ListOfDoctorsState extends State<ListOfDoctors> {
  List<dynamic> doctors = []; // Declare as a non-nullable list
  final HomeServices homeServices = HomeServices();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    fetchAllDoctors();
  }

  void fetchAllDoctors() async {
    final fetchedDoctors = await homeServices.fetchAllDoctor(context);
    setState(() {
      doctors = fetchedDoctors;
    });
  }

  void navigateToDetailPage({
    required String name,
    required String email,
    required String password,
    required String description,
    required List<String> images,
    required String phone,
    required String medicalliecensenumber,
    required String specialization,
    required String gender,
    required String type,
    String? id,
  }) {
    final arguments = {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'description': description,
      'images': images,
      'phone': phone,
      'medicalliecensenumber': medicalliecensenumber,
      'specialization': specialization,
      'gender': gender,
      'type': type,
    };

    Navigator.pushNamed(
      context,
      DoctorDetailScreen.routeName,
      arguments: arguments,
    );
  }

  void NavigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<PatientProvider>(context).patient;
    final patient_name = patient.name;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Doctors",style: TextStyle(fontWeight: FontWeight.bold),),
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
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctorData = doctors[index];
          return Padding(
            padding: const EdgeInsets.only(left : 10,bottom: 18,top: 10),
            child: GestureDetector(
              onTap: () => navigateToDetailPage(
                name: doctorData.name,
                email: doctorData.email,
                password: doctorData.password,
                description: doctorData.description,
                images: doctorData.images,
                phone: doctorData.phone,
                medicalliecensenumber: doctorData.medicalliecensenumber,
                specialization: doctorData.specialization,
                gender: doctorData.gender,
                type: doctorData.type,
                id: doctorData.id,
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(doctorData.images[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. ${doctorData.name}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(doctorData.specialization),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Ionicons.star,
                            color: Colors.yellow[700],
                            size: 18,
                          ),
                           Padding(
                            padding: EdgeInsets.only(left: 4, right: 6),
                            child: Text(
                              " ${doctorData.star}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),

                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
