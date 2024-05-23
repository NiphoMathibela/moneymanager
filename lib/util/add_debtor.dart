// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moneymanager/util/my_button.dart';

class AddDebtorDialog extends StatelessWidget {
  final controller;
  final controller2;
  VoidCallback onSave;
  VoidCallback onCancel;


 AddDebtorDialog(
      {super.key,
      required this.controller,
      required this.controller2,
      required this.onSave,
      required this.onCancel,
      });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // ignore: prefer_const_constructors
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      content: Container(
        height: 216,
        child: Column(children: [
          //Name input
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new debtor",
                filled: true,
                fillColor: Color.fromRGBO(245, 245, 245, 1),
              ),
            ),
          ),

          //Amount input
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: TextField(
              controller: controller2,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Loan amount",
                  filled: true,
                  fillColor: Color.fromRGBO(245, 245, 245, 1)),
            ),
          ),

          //Buttons
          Row(
            children: [
              //Save button
              Expanded( flex:1, child: MyButton(text: "Save", onPressed: onSave)),

              SizedBox(width: 10),

              //Cancel button
              Expanded(flex: 1, child: MyButton(text: "Cancel", onPressed: onCancel)),
            ],
          )
        ]),
      ),
    );
  }
}
