// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maya_by_myai_robotics/components/Inputs/text_input.dart';
import 'package:maya_by_myai_robotics/controllers/Providers/auth_providers.dart';
import 'package:maya_by_myai_robotics/screens/auth/components/onboarding.dart';
import 'package:maya_by_myai_robotics/screens/auth/components/sso.dart';
import 'package:http/http.dart' as http;
import 'package:maya_by_myai_robotics/screens/auth/register/otp.dart';
import 'dart:convert';

import 'package:maya_by_myai_robotics/utilities/constants.dart';

const String logoName = 'assets/svgs/logo.svg';
final Widget logo = SvgPicture.asset(
  logoName,
);

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();

  bool emailError = false;
  bool isLoading = false;
  String _validationResult = '';

  bool _validateEmail(String email) {
    // Basic email format validation using a regular expression
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  void _validateAndShowResult() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        emailError = true;
        _validationResult = 'Email cannot be empty';
        isLoading = false;
      });
    } else if (!_validateEmail(email)) {
      setState(() {
        emailError = true;
        _validationResult = 'Invalid email format';
        isLoading = false;
      });
    } else {
      setState(() {
        emailError = false;
        _validationResult = 'Email is valid';
        isLoading = false;
      });
    }
  }

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
                          Positioned(
                            width: MediaQuery.of(context).size.width * 0.6,
                            right: 16,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20, // Adjust the radius as needed
                              child: Icon(
                                Icons.help,
                                color:
                                    Colors.black, // Change the color to black
                              ),
                            ),
                          ),
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
                              'Create your account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 46),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LoginTitleTextFieldTile(
                                  whichController: emailController,
                                  size: size,
                                  hint: 'Enter Email Address',
                                  title: 'Email',
                                  keyboardtype: TextInputType.emailAddress,
                                  isloading: false,
                                  isSecured: false,
                                  onChanged: (value) {
                                    _validateAndShowResult();
                                    if (_validationResult == 'Email is valid') {
                                      emailError = false;
                                    } else {
                                      emailError = true;
                                    }
                                  },
                                ),
                                emailError
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 2),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            _validationResult,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(height: 16),
                                Visibility(
                                  visible: !isLoading,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Handle OTP verification or other actions
                                        _login();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 30),
                                        backgroundColor: Color(
                                            0xFF6998EF), // Set the background color
                                        foregroundColor:
                                            Colors.white, // Set the text color
                                        minimumSize: Size(double.infinity,
                                            48), // Set full width
                                      ),
                                      child: Text('Get Started'),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isLoading,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Handle OTP verification or other actions
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        backgroundColor: Color.fromARGB(
                                            255,
                                            238,
                                            242,
                                            249), // Set the background color
                                        foregroundColor:
                                            Colors.white, // Set the text color
                                        minimumSize: Size(double.infinity,
                                            10), // Set full width
                                      ),
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                )
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
                                child: SSOs(type: SSOType.vertical)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account? '),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Add navigation logic to another page
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Log in',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    ));
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email must not be empty';
    }
    return '';
  }

  Future<void> _login() async {
    try {
      // validate the email input
      setState(() {
        _validationResult = '';
        isLoading = true;
      });
      _validateAndShowResult();
      if (!emailError) {
        setState(() {
          _validationResult = '';
          isLoading = true;
        });
        var headers = {
          'Content-Type': 'application/json',
        };
        String email = emailController.text.toString();
        var data = {"email": email};
        var dio = Dio();
        var response = await dio.request(
          '${baseUrl}auth/signup',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        );

        if (response.statusCode == 200) {
          var responseData = response.data;
          String responseStatus = responseData['status'];
          String responseMessage = responseData['message'];
          print('response ${responseData}');

          if (responseStatus == 'ERROR') {
            setState(() {
              emailError = true;
              _validationResult = responseMessage;
            });
            // if there is an error could mean that the email exist or any other error
            // if the error is there and data is null then we proceed to otp section
            if (responseData[data] == null) {
              // redirect to otp
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OTP(
                            email: email.toString(),
                          )));
            } else {
              // redirect to login
            }
          } else {}

          setState(() {
            isLoading = false;
          });
          // print(data);
        } else {
          setState(() {
            isLoading = false;
          });
          print("Error: ${response.statusMessage}");
        }
      } else {
        isLoading = false;
        print("No email given");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("An error occurred here $e");
    }
  }
}
