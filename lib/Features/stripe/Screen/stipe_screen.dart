// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// // import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart';
// import 'package:http/http.dart';
// import 'package:http/http.dart' as http;
//
// import '../Services/payment.dart';
//
//
//
//
// class Stripe_screen extends StatefulWidget {
//   const Stripe_screen({Key? key}) : super(key: key);
//
//   @override
//   State<Stripe_screen> createState() => _Stripe_screenState();
// }
//
// class _Stripe_screenState extends State<Stripe_screen> {
//
//
//
//   Future<PaymentIntentModel> createStripPaymentIntent(String appointmentid,String userid) async
//   {
//
//     http.Response response = await http.get(
//         Uri.parse('http://192.168.1.43:9000/BreathEx/strip-payment/$appointmentid/$userid'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         });
//     print(response);
//     if (response?.statusCode == 200 || response?.statusCode == 201) {
//       // If the server did return a 200 OK response,
//
//       final jsonResponse = jsonDecode(response.body);
//
//       // then parse the JSON.
//       PaymentIntentModel intentData =   PaymentIntentModel.fromJson(jsonResponse);
//       return intentData;
//     } else {
//       //
//       return PaymentIntentModel();
//     }
//   }
//   Future<String> initPaymentSheet(String appointmentid,String userid) async {
//     try {
//       // 1. create payment intent on the server
//       PaymentIntentModel data = await createStripPaymentIntent(appointmentid,userid);
//
//       // 2. initialize the payment sheet
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           // merchantDisplayName: 'Flutter Stripe Store',
//           paymentIntentClientSecret: data?.data?.paymentIntent,
//           // testEnv: true,
//           style: ThemeMode.light,
//           appearance: const PaymentSheetAppearance(
//               primaryButton: PaymentSheetPrimaryButtonAppearance(
//                   colors: PaymentSheetPrimaryButtonTheme(
//                     light: PaymentSheetPrimaryButtonThemeColors(
//                       background: Colors.redAccent,
//                     ),
//                   )
//               )
//           ),
//         ),
//       );
//
//       return data?.data?.paymentIntent ?? "";
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       return "";
//     }
//   }
//
//
//   Future<void> confirmPayment() async {
//     try {
//       // 3. display the payment sheet.
//       await Stripe.instance.presentPaymentSheet();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Payment successfully completed'),
//         ),
//       );
//
//
//
//     } on Exception catch (e) {
//
//       if (e is StripeException) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error from Stripe: ${e.error.localizedMessage}'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Unforeseen error: ${e}'),
//           ),
//         );
//       }
//     }
//   }
//
//
//   @override
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Stripe Payment"),
//         centerTitle: true,
//
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: (){
//               initPaymentSheet("656b1b73d29f65daa07913b5","6530635ad289fb39bc09bcbb");
//             },
//             child: Container(
//               width: 50,
//               height: 200,
//               decoration: BoxDecoration(
//                   color: Colors.green
//               ),
//               child: Center(
//                 child: Text("pay"),
//               ),
//             ),
//           )
//         ],
//
//       ),
//     );
//   }
// }
