// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maya_by_myai_robotics/screens/auth/login/login.dart';

const String logoName = 'assets/svgs/logo.svg';
final Widget logo = SvgPicture.asset(
  logoName,
);

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _imageOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _imageOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    // You can add any initialization logic or navigate to the next screen after animation completion
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to the login page or any other screen
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Login(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _imageOpacityAnimation,
              child: Image.asset(
                'assets/img/logoFull.png', // Replace with your animated image asset
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
