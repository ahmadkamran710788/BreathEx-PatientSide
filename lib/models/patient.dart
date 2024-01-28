import 'dart:convert';

class Patient{
  final String id;
  final String email;
  final String name;
  final String password;
  final List<String> images;
  final String medicalhistory;
  final String phonenumber;
  final String type;
  final String token;

  Patient({required this.id,required this.email,required this.name,required this.password,required this.medicalhistory,required this.phonenumber,required this.type,required this.token,required this.images});

  Map<String,dynamic>toMap(){
    return{
      'id':id,
      'email':email,
      'name':name,
      'password':password,
      'medicalhistory':medicalhistory,
      'phonenumber':phonenumber,
      'type':type,
      'images':images,
      'token':token

    };
  }
  factory Patient.fromMap(Map<String,dynamic>map){
    return Patient(
      id:map['_id'] ??'',
      email: map['email'] ??'',
      name:map['name'] ??'',
      password:map['password'] ??'',
      images: List<String>.from(map['images'])  ,
      medicalhistory:map['medicalhistory'] ??'',
      phonenumber:map['phonenumber'] ??'',
      type:map['type'] ??'',
      token:map['token'] ??'',
    );
  }
  String toJson()=>json.encode(toMap());
  factory Patient.fromJson(String source)=>Patient.fromMap(json.decode(source));


}