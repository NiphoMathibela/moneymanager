import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/services/fireauth.dart';
import 'package:moneymanager/services/firestore.dart';
import 'package:moneymanager/util/auth_button.dart';
import 'package:moneymanager/util/my_button.dart';

class SignUp extends StatefulWidget {
  final Function()? onReg;

  const SignUp({super.key, required this.onReg});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Sign in with email and password
  Future<void> signIn() async {
    print("TAPPED!!");
    print("EMAIL:" + _emailController.text);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                    height: 270,
                    child: Image(image: AssetImage('images/flux.png'))),
                const Text(
                  "Manage your finances with ease.",
                  style: TextStyle(
                      fontFamily: "ClashGrotesk",
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 54,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  height: 54,
                  child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                AuthButton(
                  btnText: "Sign In",
                  onTap: () {
                    signIn();
                  },
                ),
                const SizedBox(height: 150,),
                Row(
                  children: [
                    Text("Don't have an account? ", style: TextStyle(fontFamily: "ClashGrotesk", fontSize: 18,)),
                    GestureDetector(
                        onTap: widget.onReg,
                        child: const Text("Register", style: TextStyle(fontFamily: "ClashGrotesk", fontSize: 18, fontWeight: FontWeight.w600,  color: Color.fromRGBO(235, 178, 255, 1)),)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
