import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      required this.controller,
      required this.validator,
      this.inputFormatters,
      required this.keyboardType,
      required this.theme});

  final String label;
  final TextEditingController controller;
  final Function(String, String) validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final String theme;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: label != 'Senha' ? null : 1,
      cursorColor: theme == 'dark' ? Colors.black : Colors.white,
      obscureText: label == 'Senha' ? true : false,
      style: TextStyle(color: theme == 'dark' ? Colors.black : Colors.white),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: (value) {
        return validator(value!, label);
      },
      controller: controller,
      autofocus: false,
      cursorHeight: 20,
      decoration: InputDecoration(
        errorStyle:
            TextStyle(color: theme == 'dark' ? Colors.red : Colors.white),
        //isCollapsed: true,
        //isDense: true,
        contentPadding: const EdgeInsets.all(5),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 16,
          color: theme == 'dark' ? Colors.black : Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme == 'dark' ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
