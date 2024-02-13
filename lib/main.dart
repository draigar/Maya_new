// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:maya_by_myai_robotics/screens/welcome.dart';
import 'package:maya_by_myai_robotics/theme/theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1400, 900),
    minimumSize: Size(500, 700),
    maximumSize: Size(1400, 900),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maya',
      debugShowCheckedModeBanner: false,
      theme: MyaiColors.lightTheme,
      darkTheme: MyaiColors.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/welcome',
      routes: <String, WidgetBuilder>{
        "/welcome": (BuildContext context) => Welcome(),
      },
    );
  }
}
