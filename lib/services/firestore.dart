import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //Collection for Debtors
  final CollectionReference debtorList =
      FirebaseFirestore.instance.collection('debtorsList');

  //History collection
  final CollectionReference debtHistory =
      FirebaseFirestore.instance.collection('debtHistory');

  //CREATE: add new debtor
  Future<void> addDebtor(String docId, String name, String amount,
      String contact, bool paid, String? userId) {
    //Adding interest
    int num = int.parse(amount);
    double interestNum = num * (1 + 0.3);

    final String finalAmount = interestNum.toString();

    return debtorList.doc(docId).set({
      'name': name,
      'amount': amount,
      'interestAmount': finalAmount,
      'contact': contact,
      'paid': paid,
      'userId': userId,
      'date': DateTime.now()
    });
  }

  //READ: get debtors
  Stream<QuerySnapshot> getDebtorsStream(String? userId) {
    final debtorStream = debtorList
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .snapshots();

    return debtorStream;
  }

  //CREATE: update
  Future<void> updateDebt(
      String docId, String newName, String newAmount, bool paid) {
    //Adding interest
    int num = int.parse(newAmount);
    double interestNum = num * (1 + 0.3);

    final String finalAmount = interestNum.toString();

    return debtorList.doc(docId).update({
      'name': newName,
      'amount': newAmount,
      'interestAmount': finalAmount,
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

  //ADDING TO THE HISTORY COLLECTION
  //---------------------------------------------------------------------------
  //

  Future<void> mirrorDataToCollection2(
      String documentId, String collection1Path) async {
    // Get document data from collection1
    final docRef = debtorList.doc(documentId);
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();

      // Create a new document reference in collection2
      final newDocRef = debtHistory.doc();

      // Write data to collection2 with the new reference
      await newDocRef.set(data);
    } else {
      print("Document not found in collection1");
    }
  }

  //CREATE: add new debtor
  Future<void> addDebtorHistory(String docId, String name, String amount,
      String contact, bool paid, String? userId) {
    //Adding interest
    int num = int.parse(amount);
    double interestNum = num * (1 + 0.3);

    final String finalAmount = interestNum.toString();

    return debtHistory.doc(docId).set({
      'name': name,
      'amount': amount,
      'interestAmount': finalAmount,
      'contact': contact,
      'paid': paid,
      'userId': userId,
      'date': DateTime.now()
    });
  }

  //READ: get debtors
  Stream<QuerySnapshot> getDebtorsStreamHistory() {
    final debtorStream =
        debtHistory.orderBy('date', descending: true).snapshots();

    return debtorStream;
  }

  //Get Sum of amounts
  Future<double> calculateSum() async {
    final db = FirebaseFirestore.instance;
    final collectionRef = db.collection('debtHistory');

    double sum = 0.0;

    await collectionRef.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        sum += double.parse(doc['interestAmount'].trim());
      });
    });

    print('Sum: $sum');

    return sum;
  }

  //Get Sum of amounts if paid
  Future<double> calculatePaid() async {
    final db = FirebaseFirestore.instance;
    final collectionRef = db.collection('debtHistory');

    double sum = 0.0;

    await collectionRef.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['paid']) {
          sum += double.parse(doc['interestAmount'].trim());
        }
      });
    });

    print('Sum: $sum');

    return sum;
  }

  //CREATE: update
  Future<void> updateDebtHistory(
      String docId, String newName, String newAmount, bool paid) {
    //Adding interest
    int num = int.parse(newAmount);
    double interestNum = num * (1 + 0.3);

    final String finalAmount = interestNum.toString();

    return debtHistory.doc(docId).update({
      'name': newName,
      'amount': newAmount,
      'interestAmount': finalAmount,
      'paid': paid,
      'date': DateTime.now(),
    });
  }

  //CREATE: update single filed (paid)
  Future<void> updateSingleFieldHistory(String docId, bool paid) async {
    await debtHistory.doc(docId).update({'paid': paid});
  }
}
