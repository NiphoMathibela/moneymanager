import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      onPressed: onPressed,
      color: const Color.fromRGBO(29, 29, 33, 1),
      child: Text(text, style: const TextStyle(color: Colors.white),),
    );
  }
}
