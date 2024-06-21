import 'package:flutter/material.dart';

class ViewDebt extends StatelessWidget {
  const ViewDebt({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      content: Container(
        height: 292,
        child: const Column(
          children: [
            //Name label
            Text("Name:"),

            //Name
            Text("Jane"),

            //Amount label
            Text("Amount"),

            //Amount
            Text("5000"),

            //Interest label
            Text("Interest"),

            //Interest
            Text("500"),

            //Date label
            Text("Date"),

            //Date
            Text("10/05/2024"),

            //Contact
            Text("Contact"),

            //Contact
            Text("0794561535")
          ],
        ),
      ),
    );
  }
}
