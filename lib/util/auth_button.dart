import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String btnText;
  VoidCallback onPressed;

  AuthButton({super.key, required this.btnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12),),
        child: Center(child: Text(btnText, style: const TextStyle(color: Colors.white, fontFamily: 'ClashGrotesk'),)),
      ),
    );
  }
}
