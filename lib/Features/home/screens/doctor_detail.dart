import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:fyp_patent/constrants/error_handling.dart';
import 'package:fyp_patent/constrants/global_variables.dart';
import 'package:fyp_patent/models/review.dart';
import 'package:http/http.dart' as http;

import '../../../common/custom buttons.dart';
import '../../../constrants/utils.dart';
import '../../Appointment/Ap12.dart';

class DoctorDetailScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String description;
  final List<String> images;
  final String phone;
  final String medicalliecensenumber;
  final String specialization;
  final String gender;
  final String type;
  final String? id;

  const DoctorDetailScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
    required this.description,
    required this.images,
    required this.phone,
    required this.medicalliecensenumber,
    required this.specialization,
    required this.gender,
    required this.type,
    required this.id,
  }) : super(key: key);

  static const String routeName = '/actual-detail';

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  late List<Reviews> reviews = [];

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  void fetchReviews() async {
    try {
      final response = await http.get(
        Uri.parse('$url/doctor/all-review/${widget.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          final List<dynamic> reviewData = jsonDecode(response.body);
          setState(() {
            reviews = reviewData.map((data) => Reviews.fromJson(data)).toList();
          });
        },
      );
    } catch (e) {
      print('Error fetching reviews: $e');
    }
  }

  showModalBottomSheetWithReviews() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              tileColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingStars(
                                    value: double.parse(reviews[index].stars),
                                    starBuilder: (index, color) => Icon(
                                      Icons.star,
                                      color: color,
                                    ),
                                    starCount: 5,
                                    starSize: 20,
                                    maxValue: 5,
                                    starSpacing: 2,
                                    maxValueVisibility: true,
                                    valueLabelVisibility: false,
                                    animationDuration:
                                    const Duration(milliseconds: 1000),
                                    starOffColor: const Color(0xffe7e8ea),
                                    starColor:
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                  Text(reviews[index].content),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      widget.images.isNotEmpty ? widget.images[0] : ''),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      GlobalVariables.secondaryColor.withOpacity(0.9),
                      GlobalVariables.secondaryColor.withOpacity(0),
                      GlobalVariables.secondaryColor.withOpacity(0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 45, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(child: Icon(Icons.arrow_back)),
                            ),
                          ),
                          InkWell(
                            onTap: showModalBottomSheetWithReviews,
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child:
                              Center(child: Icon(Icons.favorite_outline)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Status: ${widget.type}",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Description ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(widget.description),
                  SizedBox(height: 15),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Phone number ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(widget.phone),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "specialization ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text('${widget.specialization} Specialist'),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Gender ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text('${widget.gender} '),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Medical Number  ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(widget.medicalliecensenumber),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      text: "Appointment",
                      onTap: () {
                        Navigator.pushNamed(
                            context, BookAppointmentScreen.routeName,
                            arguments: widget.id);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
