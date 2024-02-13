// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maya_by_myai_robotics/components/Inputs/text_input.dart';
import 'package:maya_by_myai_robotics/screens/auth/components/onboarding.dart';
import 'package:maya_by_myai_robotics/screens/auth/components/sso.dart';
import 'package:maya_by_myai_robotics/screens/auth/register/register.dart';
// import 'package:maya_by_myai_robotics/utilities/http.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:maya_by_myai_robotics/utilities/constants.dart';

const String logoName = 'assets/svgs/logo.svg';
final Widget logo = SvgPicture.asset(
  logoName,
);

late Dio _dio;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
// final http = Http();

String emailError = '';
String passwordError = '';

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    bool showLeftColumn = MediaQuery.of(context).size.width > 800;
    double leftColumnPaddingHorizontal = 40;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [Color(0xFF6998EF), Color.fromARGB(255, 221, 229, 244)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 0), // Offset to the right
          ),
        ],
      ),
      padding: EdgeInsets.all(showLeftColumn ? 0 : 50),
      child: Row(
        children: [
          // First Column with Gradient
          if (showLeftColumn)
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.only(
                    left: leftColumnPaddingHorizontal,
                    right: leftColumnPaddingHorizontal),
                child: Onboarding()),

          // Second Column with White Background
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(showLeftColumn ? 0 : 20),
                color: Colors.white, // Adjust the color as needed
              ),
              child: Column(
                children: [
                  // first column in children
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 50, 16, 10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: logo,
                          ),
                        ),
                        // Positioned(
                        //   width: MediaQuery.of(context).size.width * 0.6,
                        //   right: 16,
                        //   child: CircleAvatar(
                        //     backgroundColor: Colors.transparent,
                        //     radius: 20, // Adjust the radius as needed
                        //     child: Icon(
                        //       Icons.help,
                        //       color: Colors.black, // Change the color to black
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // second column in children
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(80, 40, 80, 10),
                      child: Column(
                        children: [
                          // Centered text
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 46),
                          LoginTitleTextFieldTile(
                            size: size,
                            whichController: emailController,
                            hint: 'Enter Email Address',
                            title: 'Email',
                            keyboardtype: TextInputType.emailAddress,
                            isloading: false,
                            isSecured: false,
                            onChanged: (value) {
                              setState(() {
                                emailError = validateEmail(value);
                              });
                            },
                          ),
                          LoginTitleTextFieldTile(
                            size: size,
                            whichController: passwordController,
                            hint: 'Enter Password',
                            title: 'Password',
                            keyboardtype: TextInputType.visiblePassword,
                            isloading: false,
                            isSecured: true,
                            onChanged: (value) {
                              setState(() {
                                passwordError = validatePassword(value);
                              });
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add functionality for button press
                                    doLogin();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 28),
                                    backgroundColor:
                                        Color(0xFF6998EF), // #6998EF color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text('Login',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account? '),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    // Add navigation logic to another page
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Register()));
                                  },
                                  child: Text(
                                    'Create an account',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 58),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Row(children: const <Widget>[
                              Expanded(
                                child: Divider(
                                  indent: 30,
                                  endIndent: 30,
                                ),
                              ),
                              Text("Continue with"),
                              Expanded(
                                  child: Divider(
                                indent: 30,
                                endIndent: 30,
                              )),
                            ]),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                              width: 250,
                              child: SSOs(type: SSOType.horizontal)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> doLogin() async {
    try {
      setState(() {
        emailError = validateEmail(emailController.text);
        passwordError = validatePassword(passwordController.text);
      });
      // check if there are errors before making request
      if (emailError.isEmpty && passwordError.isEmpty) {
        print('make request ${emailController.text.toString()}');
      }
      // var data = json.encode({"email": email, "password": password});
      // const url = "${baseUrl}auth/login";
      // final request = await http.post(Uri.parse(url), body: data);
      // if (request.statusCode == 200) {
      //   print("Result: ${request.body}");
      // }
    } catch (e) {
      print('Error ${e}');
    }
  }
}

Widget formFields({
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required Function(String) onEmailChanged,
  required Function(String) onPasswordChanged,
}) {
  return Form(
      child: Column(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.left,
              )),
          TextField(
            controller: emailController,
            onChanged: (value) {
              onEmailChanged(value);
            },
            enableSuggestions: true,
            autocorrect: false,
            decoration: InputDecoration(
              errorText: emailError.isNotEmpty ? emailError : null,
              labelStyle: TextStyle(
                  color: Colors.grey[400], fontWeight: FontWeight.w300),
              hintText: 'Enter email address',
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
              helperText: '',
              helperStyle: TextStyle(color: Colors.grey), // Label color
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Color(0xFF6998EF)), // Border color when focused
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Color.fromARGB(
                        255, 208, 60, 50)), // Border color when focused
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Color(0xFFD6D6D6)), // Border color when not focused
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Color(0xFFD6D6D6)), // Border color when not focused
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.left,
              )),
          TextField(
            controller: passwordController,
            onChanged: (value) {
              onPasswordChanged(value);
            },
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              errorText: passwordError.isNotEmpty ? passwordError : null,
              labelStyle: TextStyle(
                  color: Colors.grey[400], fontWeight: FontWeight.w300),
              hintText: 'Enter Password',
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
              helperText: '',
              helperStyle: TextStyle(color: Colors.grey), // Label color
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Color(0xFF6998EF)), // Border color when focused
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Color.fromARGB(
                        255, 208, 60, 50)), // Border color when focused
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Color(0xFFD6D6D6)), // Border color when not focused
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                    color: Color(0xFFD6D6D6)), // Border color when not focused
              ),
            ),
          ),
        ],
      ),
    ],
  ));
}

String validateEmail(String value) {
  if (value.isEmpty) {
    return 'Email must not be empty';
  }
  return '';
}

String validatePassword(String value) {
  if (value.isEmpty) {
    return 'Password must not be empty';
  }
  return '';
}
