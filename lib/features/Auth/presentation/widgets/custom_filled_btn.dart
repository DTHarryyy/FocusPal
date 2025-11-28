import 'package:flutter/material.dart';

class CustomFilledBtn extends StatelessWidget {
  final VoidCallback action;
  final String btnText;
  const CustomFilledBtn({
    super.key,
    required this.action,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: FilledButton(onPressed: action, child: Text(btnText)),
    );
  }
}
