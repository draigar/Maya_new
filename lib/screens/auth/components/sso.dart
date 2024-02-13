import 'package:flutter/material.dart';
import 'package:maya_by_myai_robotics/screens/auth/components/sso_button_vertical.dart';
import 'package:maya_by_myai_robotics/screens/auth/components/sso_buttons.dart';

enum SSOType {
  horizontal,
  vertical,
}

class SSOs extends StatelessWidget {
  final SSOType type;

  const SSOs({super.key, this.type = SSOType.vertical});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: switch (type) {
      SSOType.horizontal => horizontalSSO(),
      SSOType.vertical => verticalSSO(),
    });
  }
}

Widget horizontalSSO() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      SSOButton(type: SSOButtonType.google),
      SSOButton(type: SSOButtonType.microsoft),
      SSOButton(type: SSOButtonType.apple)
    ],
  );
}

Widget verticalSSO() {
  const double marginBottom = 20;
  return const Column(
    children: [
      SSOButtonVertical(
        label: 'Google',
        type: SSOButtonVerticalType.google,
      ),
      SizedBox(
        height: marginBottom,
      ),
      SSOButtonVertical(
        label: 'Microsoft',
        type: SSOButtonVerticalType.microsoft,
      ),
      SizedBox(
        height: marginBottom,
      ),
      SSOButtonVertical(
        label: 'Apple',
        type: SSOButtonVerticalType.apple,
      ),
    ],
  );
}
