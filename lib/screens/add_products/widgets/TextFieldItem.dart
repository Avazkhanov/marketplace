import 'package:flutter/material.dart';

class TextFieldItem extends StatelessWidget {
  const TextFieldItem(
      {super.key, required this.lebelText, required this.controller});

  final String lebelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: lebelText,
      ),
    );
  }
}
