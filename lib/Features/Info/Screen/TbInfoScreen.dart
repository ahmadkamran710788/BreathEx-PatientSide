import 'package:flutter/material.dart';

class TbInfoScreen extends StatefulWidget {

  static const String routeName='Tb-screen';

  @override
  State<TbInfoScreen> createState() => _TbInfoScreenState();
}

class _TbInfoScreenState extends State<TbInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(

          title: Text('Tuberculosis Information'),
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
              //   'assets/tb_image.jpg',
              //   height: 200,
              //   fit: BoxFit.cover,
              // ),
              SizedBox(height: 20),
              Text(
                'Tuberculosis (TB)',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Tuberculosis (TB) is an infectious disease caused by the bacterium Mycobacterium tuberculosis. It primarily affects the lungs but can also affect other parts of the body. TB is transmitted through the air when an infected person coughs or sneezes. The most common symptoms include persistent cough, chest pain, weight loss, and fatigue.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Symptoms of Tuberculosis',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Common symptoms of TB include:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('- Persistent cough that lasts for weeks'),
              Text('- Coughing up blood or phlegm'),
              Text('- Chest pain or discomfort'),
              Text('- Fatigue and weakness'),
              Text('- Unintentional weight loss'),
              Text('- Loss of appetite'),
              SizedBox(height: 20),
              Text(
                'Diagnosis and Treatment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'To diagnose TB, various tests may be conducted, including:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('- Tuberculin skin test (TB test)'),
              Text('- Chest X-ray'),
              Text('- Sputum tests'),
              SizedBox(height: 20),
              Text(
                'Treatment for TB typically involves:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                  '- Antibiotic medications prescribed by a healthcare professional'),
              Text('- Strict adherence to the treatment regimen'),
              Text('- Isolation during the infectious period'),
              SizedBox(height: 10),
              Text(
                'It is important to complete the full course of treatment to ensure effective eradication of the TB bacteria and prevent recurrence or drug resistance.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
  }
}
