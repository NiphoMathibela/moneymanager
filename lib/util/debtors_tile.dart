// ignore: unused_import
// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moneymanager/util/my_button.dart';
import 'package:moneymanager/util/toggle_paid.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DebtorTile extends StatelessWidget {
//Variables
  final String name;
  final String amount;
  final String interestAmount;
  final bool paid;
  final String docId;
  final String contact;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;
  Function(BuildContext)? viewDebtFunction;

  DebtorTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.interestAmount,
      required this.paid,
      required this.deleteFunction,
      required this.editFunction,
      required this.docId,
      required this.contact,
      required this.viewDebtFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            SlidableAction(
              onPressed: editFunction,
              icon: Icons.edit,
              backgroundColor: Color.fromRGBO(167, 254, 217, 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          decoration: BoxDecoration(
              color: Color.fromRGBO(245, 245, 245, 1),
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            //View Debdt details
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Details'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Name: $name', style: TextStyle(fontFamily: "ClashGrotesk", fontSize: 17),),
                        Text('Original amount: $amount' ,style: TextStyle(fontFamily: "ClashGrotesk", fontSize: 17),),
                        Text('Paid: ${paid ? 'Yes' : 'No'}', style: TextStyle(fontFamily: "ClashGrotesk", fontSize: 17),),
                        GestureDetector(
                            onTap: () async {
                              final phoneNumber =
                                  'tel:$contact'; // add the 'tel:' scheme
                              final uri = Uri.parse(phoneNumber);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                throw 'Could not launch $phoneNumber';
                              }
                            },
                            child: Text('Number: $contact', style: TextStyle(fontFamily: "ClashGrotesk", fontSize: 18, fontWeight: FontWeight.w500, color: const Color.fromRGBO(235, 178, 255, 1)),)),
                      ],
                    ),
                    actions: [
                      MyButton(
                        text: 'Close',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            title: Text(
              name,
              style: TextStyle(
                  fontFamily: 'ClashGrotesk',
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            // subtitle: Row(
            //   children: [
            //     Icon(
            //       Icons.contact_phone_rounded,
            //       size: 22,
            //       color: Color.fromRGBO(102, 102, 102, 1),
            //     ),
            //     Text(
            //       contact,
            //       style: TextStyle(
            //           fontFamily: 'ClashGrotesk',
            //           fontWeight: FontWeight.w400,
            //           fontSize: 14),
            //     )
            //   ],
            // ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TogglePaid(
                  isPaid: paid,
                  docId: docId,
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(Icons.monetization_on),
                Text(
                  interestAmount,
                  style: TextStyle(
                      fontFamily: "ClashGrotesk",
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
