import 'package:flutter/material.dart';


class HealthNeedSingleCard extends StatelessWidget {
  final String text;
  final Function() onTap;
  final String path;

  const HealthNeedSingleCard({
    Key? key,
    required this.text,
    required this.onTap,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          GestureDetector(
           onTap: onTap,
            child: Container(
              width: 70,
              height: 70,
              child: Card(

                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0), // Adjust the radius as needed
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0), // Same radius as above
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        path,
                        height: 30, // Adjust the height as needed
                        width: 30,  // Adjust the width as needed
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(text,overflow: TextOverflow.ellipsis,
          ),
        ],

    );
  }
}
