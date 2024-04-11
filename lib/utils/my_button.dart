import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      color: Color(0xff0F969C),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
