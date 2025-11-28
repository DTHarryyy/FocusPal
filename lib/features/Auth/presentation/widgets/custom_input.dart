import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  const CustomInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(255, 104, 103, 103),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Row(
        spacing: 10,
        children: [
          Icon(Icons.email_outlined),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hint: Text(hintText),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              obscureText: isPassword,
            ),
          ),
        ],
      ),
    );
  }
}
