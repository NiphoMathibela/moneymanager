import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //Collection for Debtors
  final CollectionReference debtorList =
      FirebaseFirestore.instance.collection('debtorsList');

  //History collection
  final CollectionReference debtHistory =
      FirebaseFirestore.instance.collection('debtHistory');


  //CREATE: add new debtor
  Future<void> addDebtor(
      String name, String amount, String contact, bool paid) {
    //Adding interest
    int num = int.parse(amount);
    double interestNum = num * (1 + 0.3);

    final String finalAmount = interestNum.toString();

    return debtorList.add({
      'name': name,
      'amount': amount,
      'interestAmount': finalAmount,
      'contact': contact,
      'paid': paid,
      'date': DateTime.now()
    });
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

  //CREATE: add new debtor
  Future<void> addDebtorHistory(
      String name, String amount, String contact, bool paid) {
    //Adding interest
    int num = int.parse(amount);
    double interestNum = num * (1 + 0.3);

    final String finalAmount = interestNum.toString();

    return debtHistory.add({
      'name': name,
      'amount': amount,
      'interestAmount': finalAmount,
      'contact': contact,
      'paid': paid,
      'date': DateTime.now()
    });
  }

  //READ: get debtors
  Stream<QuerySnapshot> getDebtorsStreamHistory() {
    final debtorStream =
        debtHistory.orderBy('date', descending: true).snapshots();

    return debtorStream;
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
    await debtorList.doc(docId).update({'paid': paid});
  }
}
