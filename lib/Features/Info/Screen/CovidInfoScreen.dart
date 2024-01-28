import 'package:flutter/material.dart';



class CovidInfoScreen extends StatefulWidget {
  static const String routeName='Covid-screen';

  @override
  State<CovidInfoScreen> createState() => _CovidInfoScreenState();
}

class _CovidInfoScreenState extends State<CovidInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('COVID-19 Information'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Image.asset(
              //   'assets/covid_image.jpg',
              //   height: 200,
              //   fit: BoxFit.cover,
              // ),
              SizedBox(height: 20),
              Text(
                'COVID-19',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'COVID-19 is a highly contagious respiratory illness caused by the novel coronavirus SARS-CoV-2. It was first identified in Wuhan, China in December 2019 and has since spread globally, leading to a pandemic. The most common symptoms include fever, cough, and difficulty breathing. However, some infected individuals may be asymptomatic or exhibit mild symptoms.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Symptoms of COVID-19',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Common symptoms of COVID-19 include:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('- Fever'),
              Text('- Cough'),
              Text('- Shortness of breath'),
              Text('- Fatigue'),
              Text('- Muscle or body aches'),
              Text('- Headache'),
              SizedBox(height: 20),
              Text(
                'Prevention and Spread',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'To prevent the spread of COVID-19, it is recommended to follow these preventive measures:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('- Wear a mask in public settings'),
              Text('- Practice social distancing (maintain at least 6 feet distance)'),
              Text('- Wash hands frequently with soap and water for at least 20 seconds'),
              Text('- Use hand sanitizer with at least 60% alcohol content'),
              SizedBox(height: 20),
              Text(
                'Testing and Treatment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'If you suspect you have been exposed to COVID-19 or are experiencing symptoms, it is recommended to:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('- Get tested at a designated testing center'),
              Text('- Self-isolate and avoid contact with others'),
              Text('- Follow the guidance of healthcare professionals'),
              SizedBox(height: 10),
              Text(
                'Currently, there is no specific treatment for COVID-19. Most cases can be managed with supportive care, such as:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('- Rest and stay hydrated'),
              Text('- Take over-the-counter medications to relieve symptoms'),
              Text('- Seek medical attention if symptoms worsen or persist'),
            ],
          ),
        ),
      );
  }
}
