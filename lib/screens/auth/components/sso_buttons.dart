import 'package:flutter/material.dart';

enum SSOButtonType {
  google,
  microsoft,
  apple,
}

class SSOButton extends StatelessWidget {
  final String? label;
  final SSOButtonType type;

  const SSOButton({super.key, this.label, this.type = SSOButtonType.google});

  @override
  Widget build(BuildContext context) {
    String imageFileName;

    switch (type) {
      case SSOButtonType.google:
        imageFileName = 'google.png';
      case SSOButtonType.microsoft:
        imageFileName = 'microsoft.png';
      case SSOButtonType.apple:
        imageFileName = 'apple.png';
    }

    return SizedBox(
      width: 60,
      height: 60,
      child: OutlinedButton(
        onPressed: () {
          // Add functionality for SSO button press
          switch (type) {
            case SSOButtonType.google:
              // Handle Google sign-in
              break;
            case SSOButtonType.microsoft:
              // Handle Microsoft sign-in
              break;
            case SSOButtonType.apple:
              // Handle Apple sign-in
              break;
          }
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          side:
              const BorderSide(color: Colors.grey), // Visible light grey border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded edges
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/$imageFileName', // Path to the image asset
              height: 35,
              width: 35,
            ),
            if (label != null) ...[
              const SizedBox(width: 8),
              Text(
                label!,
                style: const TextStyle(color: Colors.black), // Text color
              ),
            ]
          ],
        ),
      ),
    );
  }
}
