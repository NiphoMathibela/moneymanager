import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/services/fireauth.dart';
import 'package:moneymanager/services/firestore.dart';
import 'package:moneymanager/util/auth_button.dart';
import 'package:moneymanager/util/my_button.dart';

class Register extends StatefulWidget {
  final Function()? onReg;
  Register({super.key, required this.onReg});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConController = TextEditingController();

  //Sign in with email and password
  Future<void> registerUser() async {
    try {
      if (_passwordConController.text == _passwordController.text) {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordConController.text,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
                  "Create a new account.",
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
                const SizedBox(height: 6,),
                SizedBox(
                  height: 54,
                  child: TextField(
                    controller: _passwordConController,
                    decoration: const InputDecoration(
                      hintText: "Confirm Password",
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
                  btnText: "Register",
                  onTap: () {
                    registerUser();
                  },
                ),
                //Sign in if already a user
                const SizedBox(height: 100,),
                Row(
                  children: [
                    const Text("Already have an account? ", style: TextStyle(fontFamily: "ClashGrotesk", fontSize: 18,)),
                    GestureDetector(
                        onTap: widget.onReg,
                        child: const Text("Sign In", style: TextStyle(fontFamily: "ClashGrotesk", fontSize: 18, fontWeight: FontWeight.w600,  color: Color.fromRGBO(235, 178, 255, 1)),)),
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
