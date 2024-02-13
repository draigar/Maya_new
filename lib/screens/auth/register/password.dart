import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maya_by_myai_robotics/components/Inputs/text_input.dart';
import 'package:maya_by_myai_robotics/screens/auth/components/onboarding.dart';

const String logoName = 'assets/svgs/logo.svg';
final Widget logo = SvgPicture.asset(
  logoName,
);

class Password extends StatefulWidget {
  const Password({super.key, required this.email});

  final String email;

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  @override
  Widget build(BuildContext context) {
    bool showLeftColumn = MediaQuery.of(context).size.width > 800;
    double leftColumnPaddingHorizontal = 40;
    Size size = MediaQuery.of(context).size;

    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

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
                  child: const Onboarding()),
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
                      padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: logo,
                            ),
                          ),
                          Positioned(
                            width: MediaQuery.of(context).size.width * 0.6,
                            right: 16,
                            child: const CircleAvatar(
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
                        padding: const EdgeInsets.fromLTRB(80, 40, 80, 10),
                        child: Column(
                          children: [
                            // Centered text
                            const Text(
                              'Enter a password',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 46),
                            LoginTitleTextFieldTile(
                              size: size,
                              whichController: passwordController,
                              hint: 'Enter Password',
                              title: 'Enter Password',
                              keyboardtype: TextInputType.emailAddress,
                              isloading: false,
                              isSecured: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            LoginTitleTextFieldTile(
                              size: size,
                              whichController: confirmPasswordController,
                              hint: 'Enter Password',
                              title: 'Confirm Password',
                              keyboardtype: TextInputType.visiblePassword,
                              isloading: false,
                              isSecured: true,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add functionality for button press
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const OTP()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 28),
                                      backgroundColor: const Color(
                                          0xFF6998EF), // #6998EF color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text('Complete',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
