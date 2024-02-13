import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Login {
  final String email, password;
  Login({required this.email, required this.password});
}

class LoginResponse {
  final String token, message;
  final bool is_error;
  LoginResponse(
      {required this.token, required this.message, required this.is_error});
}
