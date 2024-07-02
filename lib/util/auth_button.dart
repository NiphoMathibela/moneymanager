import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthButton extends StatelessWidget {
  final String btnText;
  VoidCallback onTap;

  AuthButton({super.key, required this.btnText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12),),
        child: Center(child: Text(btnText, style: const TextStyle(color: Colors.white, fontFamily: 'ClashGrotesk', fontWeight: FontWeight.w600),)),
      ),
    );
  }
}
