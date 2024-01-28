// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// import 'package:flutter_stripe/flutter_stripe.dart';
//
// import 'package:http/http.dart' as http;
//
// class StripePaymentHandle {
//   Map<String, dynamic>? paymentIntent;
//
//
//
//
//
//
//   Future<void> stripeMakePayment() async {
//     try {
//
//       paymentIntent = await createPaymentIntent('100', 'INR');
//       await Stripe.instance
//           .initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//               billingDetails: const BillingDetails(
//                   name: 'YOUR NAME',
//                   email: 'YOUREMAIL@gmail.com',
//                   phone: 'YOUR NUMBER',
//                   address: Address(
//                       city: 'YOUR CITY',
//                       country: 'YOUR COUNTRY',
//                       line1: 'YOUR ADDRESS 1',
//                       line2: 'YOUR ADDRESS 2',
//                       postalCode: 'YOUR PINCODE',
//                       state: 'YOUR STATE')),
//               paymentIntentClientSecret: paymentIntent![
//               'sk_test_51NUsJsAR26T0VWlG8QIjAGj0z2nT47At10xeVeZi8y2xLfusUvjeeffyHMWeMKP2EmmrSe4XuTtFjMFhrj32w7iu00ic5SgdGr'], //Gotten from payment intent
//               style: ThemeMode.dark,
//               merchantDisplayName: 'Ikay'))
//           .then((value) {});
//
//       //STEP 3: Display Payment sheet
//       displayPaymentSheet();
//     } catch (e) {
//       print(e.toString());
//       // Fluttertoast.showToast(msg: e.toString());
//     print(e.toString());
//     }
//   }
//
//   displayPaymentSheet() async {
//     try {
//       // 3. display the payment sheet.
//       await Stripe.instance.presentPaymentSheet();
//       print('Payment succesfully completed');
//       // Fluttertoast.showToast(msg: 'Payment succesfully completed');
//     } on Exception catch (e) {
//       if (e is StripeException) {
//         // Fluttertoast.showToast(
//         //     msg: 'Error from Stripe: ${e.error.localizedMessage}');
//         print("Error from Stripe: ${e.error.localizedMessage}");
//       } else {
//         // Fluttertoast.showToast(msg: 'Unforeseen error: ${e}');
//         print('Unforeseen error: ${e}');
//       }
//     }
//   }
//
// //create Payment
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       //Request body
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//       };
//
//       //Make post request to Stripe
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer sk_test_51NUsJsAR26T0VWlG8QIjAGj0z2nT47At10xeVeZi8y2xLfusUvjeeffyHMWeMKP2EmmrSe4XuTtFjMFhrj32w7iu00ic5SgdGr',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }
//
// //calculate Amount
//   calculateAmount(String amount) {
//     final calculatedAmount = (int.parse(amount)) * 100;
//     return calculatedAmount.toString();
//   }
// }