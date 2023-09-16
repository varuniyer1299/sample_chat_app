import 'package:flutter/material.dart';
import 'package:flutter_course_learning/utils/text_field_styles.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool isObscured;
  const LoginTextField({super.key,this.controller,this.validator,this.hintText,this.isObscured = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isObscured,
      decoration: InputDecoration(border: OutlineInputBorder(),hintText: hintText,hintStyle: ThemeTextStyle.loginTextFieldStyle),
    );
  }
}
