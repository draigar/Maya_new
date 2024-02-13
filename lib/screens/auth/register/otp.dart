// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maya_by_myai_robotics/screens/auth/register/password.dart';
import 'package:maya_by_myai_robotics/screens/auth/register/register.dart';
import 'package:maya_by_myai_robotics/utilities/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class OTP extends StatefulWidget {
  const OTP({super.key, required this.email});

  final String email;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  bool otpError = true;
  bool isLoading = false;
  bool isValidating = false;
  String _validationResult = '';

  @override
  void initState() {
    super.initState();
    // Make Dio request in initState
    fetchData();
  }

  void displayToast(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: message,
      ),
    );
  }

  void fetchData() async {
    setState(() {
      isLoading = false;
    });
    try {
      var dio = Dio();
      var headers = {
        'Content-Type': 'application/json',
      };
      String encodedEmail = widget.email;
      var data = {"email_address": encodedEmail};
      var response = await dio.request(
        '${baseUrl}auth/signup/confirmation/resend',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        var responseData = response.data;
        String responseStatus = responseData['status'];
        var data = responseData['data'];
        print('Result $data');
        if (responseStatus != 'OK') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
        } else {
          setState(() {
            otpError = true;
            _validationResult = data['message'];
          });
        }
      } else {
        print("Error: - ${response.statusMessage}");
        setState(() {
          otpError = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = true;
        otpError = false;
      });
      // Handle errors
      print('Error: $e');
    }
  }

  void validateCode(String otp) async {
    print(otp);
    setState(() {
      isValidating = false;
      otpError = true;
      _validationResult = '';
    });
    try {
      var dio = Dio();
      var headers = {
        'Content-Type': 'application/json',
      };
      String encodedEmail = widget.email;
      var data = {"email": encodedEmail, "code": otp};
      var response = await dio.request(
        '${baseUrl}auth/signup/confirm',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      setState(() {
        isValidating = false;
      });

      if (response.statusCode == 200) {
        var responseData = response.data;
        var data = responseData['verification_code_expiry'];
        String responseStatus = responseData['status'];
        String responseMessage = responseData['message'];
        print('Result - $data');
        if (responseStatus == 'OK') {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             Password(email: encodedEmail.toString(), password_reset_token: )));
        } else {
          setState(() {
            otpError = true;
            _validationResult = responseMessage;
          });
        }
      } else {
        print("Error: - ${response.statusMessage}");
      }
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      // Handle errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF6998EF), Color.fromARGB(255, 221, 229, 244)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0), // Offset to the right
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 320),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Set the background color
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 20.0,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 20, // Adjust the radius as needed
                    child: Icon(
                      Icons.help,
                      color: Colors.black, // Change the color to black
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // first section
                  headingTextAndSubText(),
                  otpInputAndResend(),
                  Visibility(
                    visible: !isValidating,
                    child: SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle OTP verification or other actions
                          String enteredOTP = otpControllers
                              .map((controller) => controller.text)
                              .join();
                          print('Entered OTP: $enteredOTP');
                          validateCode(enteredOTP);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          backgroundColor:
                              Color(0xFF6998EF), // Set the background color
                          foregroundColor: Colors.white, // Set the text color
                          minimumSize:
                              Size(double.infinity, 48), // Set full width
                        ),
                        child: Text('Verify OTP'),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isValidating,
                    child: SizedBox(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          backgroundColor: Color.fromARGB(
                              255, 118, 130, 154), // Set the background color
                          foregroundColor: Colors.white, // Set the text color
                          minimumSize:
                              Size(double.infinity, 48), // Set full width
                        ),
                        child: Text('Validating OTP'),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget headingTextAndSubText() {
    return Column(
      children: [
        Text(
          'Verify your email address',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 400,
          child: Text(
            'Kindly enter a 6-Digit OTP sent to your Email Address to continue registration',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(116, 116, 119, 1),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        if (otpError)
          Center(
            child: Text(
              _validationResult,
              style: TextStyle(color: Colors.red[600]),
            ),
          )
      ],
    );
  }

  Widget otpInputAndResend() {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => buildOTPInputBox(index),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Visibility(
          visible: !isLoading,
          child: SizedBox(
            child: TextButton(
              onPressed: () {
                // Handle resend code action
                print('Resending code...');
                fetchData();
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFEDF2FD), // Set the background color
              ),
              child: Text(
                'Resend Code',
                style: TextStyle(
                  color: Colors.black, // Set the text color
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: SizedBox(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFEDF2FD), // Set the background color
              ),
              child: Text(
                'Sending code...',
                style: TextStyle(
                  color:
                      Color.fromARGB(255, 176, 169, 169), // Set the text color
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOTPInputBox(int index) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: 1 * size.width / 100),
      child: SizedBox(
        width: 4 * size.width / 100,
        height: 6 * size.height / 100,
        child: TextField(
          controller: otpControllers[index],
          maxLength: 1,
          obscureText: true,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          // style: TextStyle(fontSize: 30),
          decoration: InputDecoration(
            counterText: '', // Hide the character count
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color(0xFFBABBBE)), // Set the border color
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onChanged: (value) {
            // Handle OTP input changes if needed
          },
        ),
      ),
    );
  }
}
