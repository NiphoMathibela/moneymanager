// ignore: unused_import
// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moneymanager/util/toggle_paid.dart';

// ignore: must_be_immutable
class DebtorTile extends StatelessWidget {
//Variables
  final String name;
  final String amount;
  final bool paid;
  final String docId;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;

  DebtorTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.paid,
      required this.deleteFunction,
      required this.editFunction,
      required this.docId,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
            title: Text(name, style: TextStyle(fontFamily: 'ClashGrotesk', fontWeight: FontWeight.w500, fontSize: 16),),
            subtitle: Row(
              children: const [
                Icon(Icons.contact_phone_rounded, size: 22, color: Color.fromRGBO(102, 102, 102, 1),),
                Text(" 079 456 1535",style: TextStyle(fontFamily:'ClashGrotesk', fontWeight: FontWeight.w400, fontSize: 14),)
              ],
            ),
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
                Text(amount, style: TextStyle(fontFamily: "ClashGrotesk", fontSize: 12, fontWeight: FontWeight.w500),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
