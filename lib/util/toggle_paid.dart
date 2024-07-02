import 'package:flutter/material.dart';
import 'package:moneymanager/services/firestore.dart';

// ignore: must_be_immutable
class TogglePaid extends StatelessWidget {
  bool isPaid;
  String docId;

  final FireStoreService fireStoreService = FireStoreService();

  changePaid(bool paid, String docId) async {
    bool newPaid = !paid;

    // Check if the paid value has changed
    if (newPaid != paid) {
      // Update the Firestore field
      await fireStoreService.updateSingleField(docId, newPaid);
      await fireStoreService.updateSingleFieldHistory(docId, newPaid);
    }
  }

  TogglePaid({
    super.key,
    required this.isPaid,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          changePaid(isPaid, docId), // Call the changePaid function here
      child: Container(
        height: 25,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isPaid ? const Color.fromRGBO(167, 254, 217, 1) : Colors.red,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(isPaid ? "Paid" : "Unpaid", style: TextStyle(fontFamily: "ClashGrotesk"),),
                const Icon(Icons.arrow_drop_down)
              ]),
        ),
      ),
    );
  }
}
