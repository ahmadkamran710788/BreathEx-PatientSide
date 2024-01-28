import 'package:flutter/material.dart';



class PneumoniaInfoScreen extends StatefulWidget {
  static const String routeName='Pneumonia-screen';

  @override
  State<PneumoniaInfoScreen> createState() => _PneumoniaInfoScreenState();
}

class _PneumoniaInfoScreenState extends State<PneumoniaInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text('Pneumonia Information'),
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
              //   'assets/pneumonia_image.jpg',
              //   height: 200,
              //   fit: BoxFit.cover,
              // ),
              SizedBox(height: 20),
              Text(
                'Pneumonia',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Pneumonia is an infection that inflames the air sacs in one or both lungs. The air sacs may fill with fluid or pus (purulent material), causing cough with phlegm or pus, fever, chills, and difficulty breathing. Pneumonia can range in seriousness from mild to life-threatening.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Symptoms of Pneumonia',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'The symptoms of pneumonia can vary depending on the cause and the individual, but common symptoms include:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('- Cough with phlegm or pus'),
              Text('- Fever'),
              Text('- Chills'),
              Text('- Shortness of breath'),
              Text('- Rapid breathing'),
              SizedBox(height: 20),
              Text(
                'Causes of Pneumonia',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Pneumonia can be caused by various infectious agents, including bacteria, viruses, and fungi. The most common causes of pneumonia are:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('- Streptococcus pneumoniae'),
              Text('- Haemophilus influenzae'),
              Text('- Mycoplasma pneumoniae'),
              Text('- Influenza viruses'),
              SizedBox(height: 20),
              Text(
                'Prevention and Treatment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Preventive measures for pneumonia include:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('- Vaccination against bacterial and viral infections'),
              Text('- Washing hands regularly'),
              Text('- Avoiding close contact with sick individuals'),
              SizedBox(height: 10),
              Text(
                'Treatment for pneumonia depends on the cause and severity of the infection. It may involve:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('- Antibiotics for bacterial pneumonia'),
              Text('- Antiviral medications for viral pneumonia'),
              Text('- Rest and supportive care'),
            ],
          ),
        ),
      );
  }
}
