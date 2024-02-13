import 'package:flutter/material.dart';

enum SSOButtonVerticalType {
  google,
  microsoft,
  apple,
}

class SSOButtonVertical extends StatelessWidget {
  final String? label;
  final SSOButtonVerticalType type;

  const SSOButtonVertical(
      {super.key, this.label, this.type = SSOButtonVerticalType.google});

  @override
  Widget build(BuildContext context) {
    String imageFileName;

    switch (type) {
      case SSOButtonVerticalType.google:
        imageFileName = 'google.png';
      case SSOButtonVerticalType.microsoft:
        imageFileName = 'microsoft.png';
      case SSOButtonVerticalType.apple:
        imageFileName = 'apple.png';
    }

    return SizedBox(
      width: 221,
      height: 60,
      child: OutlinedButton(
        onPressed: () {
          // Add functionality for SSO button press
          switch (type) {
            case SSOButtonVerticalType.google:
              // Handle Google sign-in
              break;
            case SSOButtonVerticalType.microsoft:
              // Handle Microsoft sign-in
              break;
            case SSOButtonVerticalType.apple:
              // Handle Apple sign-in
              break;
          }
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          side:
              const BorderSide(color: Colors.grey), // Visible light grey border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded edges
          ),
        ),
        child: Row(
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
