// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginTitleTextFieldTile extends StatelessWidget {
  LoginTitleTextFieldTile({
    super.key,
    required this.size,
    required this.whichController,
    required this.hint,
    required this.title,
    required this.keyboardtype,
    this.onChanged,
    required this.isloading,
    this.validator,
    this.inputFormatters,
    required this.isSecured,
    // required this.errorText,
  });

  final Size size;
  final TextEditingController whichController;
  List<TextInputFormatter>? inputFormatters;
  String hint;
  String title;
  TextInputType keyboardtype;
  void Function(String)? onChanged;
  bool isloading;
  String? Function(String?)? validator;
  bool isSecured = false;
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1 * size.width / 100),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 90 * size.width / 100,
            child: Material(
              // elevation: 1,
              shadowColor: const Color(0xffdbeae6),
              child: TextFormField(
                onChanged: onChanged,
                enabled: isloading ? false : true,
                showCursor: true,
                inputFormatters: inputFormatters,
                cursorColor: Colors.grey,
                controller: whichController,
                keyboardType: keyboardtype,
                obscureText: isSecured,
                decoration: InputDecoration(
                  errorText: errorText,
                  fillColor: const Color(0xfff8f8f8),
                  filled: true,
                  // errorText: errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        color: Color(0xFF6998EF)), // Border color when focused
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(
                            255, 208, 60, 50)), // Border color when focused
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        color:
                            Color(0xFFD6D6D6)), // Border color when not focused
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        color:
                            Color(0xFFD6D6D6)), // Border color when not focused
                  ),
                  hintText: hint,
                  hintStyle: const TextStyle(
                    color: Color(0xffc2c4cf),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                validator: validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class CustomTextField extends StatefulWidget {
//   CustomTextField({
//     required this.size,
//     required this.controller,
//     required this.hint,
//     required this.title,
//     required this.keyboardType,
//     this.onChanged,
//     this.isLoading = false,
//     this.validators,
//     this.inputFormatters,
//     required this.obscureText,
//   });

//   final Size size;
//   final TextEditingController controller;
//   final String hint;
//   final String title;
//   final TextInputType keyboardType;
//   final Function(String)? onChanged;
//   final bool isLoading;
//   final List<String Function(String?)>? validators;
//   final List<TextInputFormatter>? inputFormatters;
//   bool obscureText;

//   @override
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 7 * widget.size.height / 100,
//       child: Stack(
//         alignment: Alignment.centerRight,
//         children: [
//           TextFormField(
//             controller: widget.controller,
//             keyboardType: widget.keyboardType,
//             onChanged: widget.onChanged,
//             enabled: !widget.isLoading,
//             obscureText: obscureText,
//             validator: (value) {
//               if (widget.validators != null) {
//                 for (var validate in widget.validators!) {
//                   final result = validate(value);
//                   return result;
//                 }
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               hintText: widget.hint,
//               labelText: widget.title,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide(
//                   color: Color(0xFFD6D6D6),
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide(
//                   color: Color(0xFFD6D6D6),
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide(
//                   color: Color(0xFFD6D6D6),
//                 ),
//               ),
//               labelStyle: TextStyle(
//                 color: Color(0xFFB3B3B3),
//               ),
//               hintStyle: TextStyle(
//                 color: Color(0xFFB3B3B3),
//               ),
//               errorStyle: TextStyle(
//                 color: Theme.of(context).colorScheme.error,
//               ),
//             ),
//             inputFormatters: widget.inputFormatters,
//           ),
//           if (widget.obscureText)
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _obscureText = !_obscureText;
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Icon(
//                   _obscureText
//                       ? Icons.visibility_sharp
//                       : Icons.visibility_off_sharp,
//                   color: Color(0xFFB3B3B3),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
