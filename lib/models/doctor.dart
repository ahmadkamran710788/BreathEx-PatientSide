import 'dart:convert';

class Doctor{
  final String name;
  final String email;
  final String password;
  final String description;
  final List<String> images;
  final String phone;
  final String medicalliecensenumber;
  final Map<String, List<String>> availableOnlineHours;
  final String specialization;
  final String gender;
  final String type;
  final int star;


  String? id;


  Doctor({
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
    required this.availableOnlineHours,
    this.id,
    required this.star,



  });


  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'password':password,
      'star':star,
      'description':description,
      'images':images,
      'phone':phone,
      'availableOnlineHours':availableOnlineHours,
      'medicalliecensenumber':medicalliecensenumber,
      'specialization':specialization,
      'gender':gender,
      'type':type,
      'id':id,

    };

  }
  factory Doctor.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic>? availableHoursMap = map['availableOnlineHours'];
    Map<String, List<String>> availableOnlineHours = {};

    if (availableHoursMap != null) {
      availableHoursMap.forEach((key, value) {
        if (value is List<String>) {
          availableOnlineHours[key] = value;
        } else if (value is List<dynamic>) {
          // If the values are of dynamic type, cast them to String
          availableOnlineHours[key] = value.map((dynamic item) => item.toString()).toList();
        }
      });
    }

    return Doctor(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      description: map['description'] ?? '',
      images: List<String>.from(map['images']),
      phone: map['phone'] ?? '',
      star: map['star'] ?? 0,
      availableOnlineHours: availableOnlineHours,
      medicalliecensenumber: map['medicalliecensenumber'] ?? '',
      specialization: map['specialization'] ?? '',
      gender: map['gender'] ?? '',
      type: map['type'] ?? '',
      id: map['_id'] ?? '',
    );
  }


  String toJson()=>json.encode(toMap());
  factory Doctor.fromJson(String source)=>Doctor.fromMap(json.decode(source));


}