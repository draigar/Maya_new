import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:maya_by_myai_robotics/utilities/constants.dart';

class AuthProviders extends ChangeNotifier {
  var regStatusCode, regMesage, regStatus;
  bool regIsLoading = false;

  Future<String?> registerUser(
    String email,
    String username,
    String phone,
    String password,
  ) async {
    regIsLoading = true;
    notifyListeners();
    var response = await http.post(
      Uri.parse('${baseUrl}auth/register'),
      // headers: {
      //   'Content-Type': 'application/json',
      //   // 'Authorization': 'Bearer ${getuser.token}',
      // },
      body: {
        "username": username,
        "phone_number": phone,
        "email": email,
        "password": password,
      },
    );
    print('this is the reg user response code ${response.statusCode}');

    regIsLoading = false;
    notifyListeners();
    var data = response.body;
    print(data);
    if (response.statusCode == 201) {
      String responseString = response.body;
      regStatus = jsonDecode(responseString)['status'];
      regMesage = jsonDecode(responseString)['message'];

      return regStatus;
    } else {
      String responseString = response.body;
      regStatus = jsonDecode(responseString)['status'];
      regMesage = jsonDecode(responseString)['message'];
    }
    notifyListeners();
    return null;
  }
}
