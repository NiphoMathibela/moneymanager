import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text("Welcome!", style: TextStyle(fontFamily: "ClashGrotesk", fontWeight: FontWeight.w700, fontSize: 48),),
              const Text("Sign and manage your finances with ease.", style: TextStyle(fontFamily: "ClashGrotesk", fontWeight: FontWeight.w400, fontSize: 20),),
              SizedBox(
                height: 54,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    contentPadding: EdgeInsets.all(14),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color.fromRGBO(245, 245, 245, 1),
                  ),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
