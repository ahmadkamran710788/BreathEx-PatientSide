import 'package:fyp_patent/Features/Auth/Services/auth_services.dart';
import 'package:fyp_patent/common/custom%20buttons.dart';
import 'package:fyp_patent/constrants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:fyp_patent/common/custom_textfield.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const  routeName='/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService=AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  void signUpUser(){
    authService.signUpUser(context: context, email: _emailController.text, password: _passwordController.text, name: _nameController.text, phonenumber: _numberController.text);
  }
  void signInUser(){
    authService.signInUser(context: context, email: _emailController.text, password: _passwordController.text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: GlobalVariables.SignupBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("BreathEx", style: TextStyle(color: Colors.white, fontSize: 40),),
                  SizedBox(height: 10,),
                  Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          tileColor: _auth == Auth.signup ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                          title: Text(
                            "Create Account",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Radio(
                            activeColor: GlobalVariables.secondaryColor,
                            value: Auth.signup,
                            groupValue: _auth,
                            onChanged: (Auth? val) {
                              setState(() {
                                _auth = val!;
                              });
                            },
                          ),
                        ),
                        if (_auth == Auth.signup)
                          Form(
                            key: _signUpFormKey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, 0.3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      CustomTextFeld(controller: _nameController, hintText: "Name"),
                                      CustomTextFeld(controller: _emailController, hintText: "Email"),
                                      CustomTextFeld(controller: _passwordController, hintText: "Password"),
                                      CustomTextFeld(controller: _numberController, hintText: "Number"),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40,),
                                CustomButton(text: "SignUp", onTap: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    print("hello");
                                    signUpUser();
                                  }
                                }),
                              ],
                            ),
                          ),
                        ListTile(
                          tileColor: _auth == Auth.signup ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                          title: Text(
                            "Sign in",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Radio(
                            activeColor: GlobalVariables.secondaryColor,
                            value: Auth.signin,
                            groupValue: _auth,
                            onChanged: (Auth? val) {
                              setState(() {
                                _auth = val!;
                              });
                            },
                          ),
                        ),
                        if (_auth == Auth.signin)
                          Form(
                            key: _signInFormKey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 10,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      CustomTextFeld(controller: _emailController, hintText: "Email"),
                                      CustomTextFeld(controller: _passwordController, hintText: "Password"),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40,),
                                CustomButton(text: "SignIn", onTap: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();



                                  }
                                }),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
