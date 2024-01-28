
import 'package:flutter/material.dart';

import 'CovidInfoScreen.dart';
import 'PneumoniaInfoScreen.dart';
import 'TbInfoScreen.dart';




class InfoBoxScreen extends StatelessWidget {
  static const String routeName='info-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Health Information'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            GestureDetector(
              onTap: () =>Navigator.pushNamed(context,PneumoniaInfoScreen.routeName),
              child: InfoBox(
                title: 'Pneumonia',
                description:
                'Pneumonia is an infection that inflames the air sacs in one or both lungs...',
                color: Colors.green,
              ),
            ),
            GestureDetector(
              onTap: ()=> Navigator.pushNamed(context,TbInfoScreen.routeName),
              child: InfoBox(
                title: 'Tuberculosis (TB)',
                description:
                'Tuberculosis (TB) is an infectious disease that primarily affects the lungs...',
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  InfoBox({
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }}
