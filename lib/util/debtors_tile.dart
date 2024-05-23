// ignore: unused_import
// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class DebtorTile extends StatelessWidget {
//Variables
  final String name;
  final String amount;
  final bool paid;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;

  DebtorTile({
    super.key,
    required this.name,
    required this.amount,
    required this.paid,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
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
          // ignore: prefer_const_constructors
          padding: EdgeInsets.only(top: 4, bottom: 4),
          decoration: BoxDecoration(
              color: Color.fromRGBO(245, 245, 245, 1),
              borderRadius: BorderRadius.circular(10)),

          child: ListTile(
            leading: Checkbox(value: paid, onChanged: onChanged),
            title: Text(name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.monetization_on), Text(amount)],
            ),
          ),
        ),
      ),
    );
  }
}
