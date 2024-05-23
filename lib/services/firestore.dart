import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //Collect Debtors
  final CollectionReference debtorList =
      FirebaseFirestore.instance.collection('debtorsList');

  //CREATE: add new debtor
  Future<void> addDebtor(String name, String amount) {
    return debtorList
        .add({'name': name, 'amount': amount, 'date': DateTime.now()});
  }

  //READ: get debtors
  Stream<QuerySnapshot> getDebtorsStream(){
    final debtorStream = debtorList.orderBy('date', descending: true).snapshots();

    return debtorStream;
  }

  //CREATE: update

  //DELETE delete debtors
}
