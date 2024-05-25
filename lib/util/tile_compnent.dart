import 'package:flutter/material.dart';

class TileComponent extends StatelessWidget {
  const TileComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
          color: Color.fromRGBO(245, 245, 245, 1),
          borderRadius: BorderRadius.circular(10)),

      //List tile
      child: ListTile(
        leading: Icon(Icons.email),
        title: Text("Change email"),
      ),
    );
  }
}
