import 'package:flutter/material.dart';
import 'package:moneymanager/pages/register.dart';
import 'package:moneymanager/pages/signup_page.dart';

class SignupOrLogin extends StatefulWidget {
  const SignupOrLogin({super.key});

  @override
  State<SignupOrLogin> createState() => _SignupOrLoginState();
}

class _SignupOrLoginState extends State<SignupOrLogin> {
  //initially show login page
  bool showLogin = true;

//Toggle the boolean state
  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return SignUp(onReg: togglePages,);
    } else {
      return Register(onReg: togglePages,);
    }
  }
}
