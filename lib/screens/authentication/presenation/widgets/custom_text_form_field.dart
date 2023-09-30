import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.suffixIcon,
      this.suffix,
      required this.controller,
      required this.hintText,
      required this.prefix,
      required this.obscureText,
      required this.type,
      this.onChanged,
      this.validate})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final IconData prefix;
  final bool obscureText;
  final TextInputType type;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  final String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: type,
        validator: validate,
        decoration: InputDecoration(
            hintText: hintText,
            suffix: suffix,
            suffixIcon: suffixIcon,
            prefixIcon: Icon(prefix),
            focusedBorder: buildOutlineInputBorder(),
            enabledBorder: buildOutlineInputBorder(),
            border: buildOutlineInputBorder()));
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(16));
  }
}
