import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Field extends StatelessWidget {
  const Field({
    super.key,
    required this.fErrorText,
    required this.fField,
    required this.validator,
    required this.label,
    required this.hint,
    this.kbtype,
    this.suffix,
    required this.prefix,
    required this.obscure,
  });

  final String? fErrorText;

  final TextEditingController fField;

  final String? Function(String?)? validator;
  final String label;
  final String hint;
  final TextInputType? kbtype;
  final Widget? suffix;
  final Widget? prefix;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: prefix,
        errorText: fErrorText,
        suffixIcon: suffix,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, // Border color when the field is enabled
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(
                255, 255, 255, 255), // Border color when the field is focused
          ),
        ),
        errorStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 121, 121),
          fontWeight: FontWeight.bold,
        ),
      ),
      controller: fField,
      keyboardType: kbtype,
      validator: validator,
      obscureText: obscure,
      style: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255), // Font color of the text
      ),
    );
  }
}
