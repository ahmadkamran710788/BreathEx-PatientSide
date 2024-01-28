
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:fyp_patent/constrants/utils.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}){
  switch (response.statusCode){
    case 200:
      onSuccess();
      break;
    case 400:
      ssb(context,jsonDecode(response.body)['msg']);
      break;
    case 500:
      ssb(context,jsonDecode(response.body)['error']);
      break;

    default:
      ssb(context,response.body);
      break;
  }
}