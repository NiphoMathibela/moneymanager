import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //Collect Debtors
  final CollectionReference debtorList =
      FirebaseFirestore.instance.collection('debtorsList');

  //CREATE: add new debtor
  Future<void> addDebtor(String name, String amount, String contact, bool paid) {
    return debtorList.add(
        {'name': name, 'amount': amount, 'contact':contact, 'paid': paid, 'date': DateTime.now()});
  }

  //READ: get debtors
  Stream<QuerySnapshot> getDebtorsStream() {
    final debtorStream =
        debtorList.orderBy('date', descending: true).snapshots();

    return debtorStream;
  }

  //CREATE: update
  Future<void> updateDebt(
      String docId, String newName, String newAmount, bool paid) {
    return debtorList.doc(docId).update({
      'name': newName,
      'amount': newAmount,
      'paid': paid,
      'date': DateTime.now(),
    });
  }

  //CREATE: update single filed (paid)
Future<void> updateSingleField(String docId, bool paid) async {

    await debtorList.doc(docId).update({'paid': paid});

}

  //DELETE delete debtors
  Future<void> deleteDebt(String docId) {
    return debtorList.doc(docId).delete();
  }
}
