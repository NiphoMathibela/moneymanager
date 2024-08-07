import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/pages/account_page.dart';
import 'package:moneymanager/pages/history_page.dart';
import 'package:moneymanager/services/firestore.dart';
import 'package:moneymanager/util/add_debtor.dart';
import 'package:moneymanager/util/debtors_tile.dart';
import 'package:moneymanager/util/view_debt.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Access firestore
  final FireStoreService fireStoreService = FireStoreService();

  //Text controller
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final _numberController = TextEditingController();

  //User ID
  String? _uid;

  //User change stream
  Stream<User?> authStateChanges = FirebaseAuth.instance.authStateChanges();

  @override
  void initState() {
    super.initState();

    authStateChanges.listen((User? user) {
      if (user != null) {
        // User is signed in
        _uid = user.uid;
        print('Logged in user UID: $_uid');
      } else {
        // User is signed out
        _uid = null;
        print('No user is currently signed in.');
      }
    });
  }

  //Navigation functions
  int _currentIndex = 0;

  final List<Widget> _pages = [HomePage(), HistoryPage(), AccountPage()];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  //List of debtors
  List debtors = [
    ["J Swanson", "2000", false],
    ["Richie Rich", "1000", false],
    ["Eric Swanson", "2500", false],
  ];

  //Save debtor
  void saveNewDebtor() {
    setState(() {
      debtors.add([_controller.text, _controller2.text, false]);
      _controller.clear();
      _controller2.clear();
    });

    Navigator.of(context).pop();
  }

  //Get data to display in text fields
  Future<void> _loadDocumentData(String docId) async {
    print("Printing...");
    final firestore = FirebaseFirestore.instance;
    final documentSnapshot =
        await firestore.collection("debtorList").doc(docId).get();

    final documentData = documentSnapshot.data();
    final nameText = documentData?['name'];
    final amountText = documentData?['amount'];
    final interestAmountText = documentData?['interestAmount'];
    final contactText = documentData?['contact'];

    setState(() {
      _controller.text = nameText ?? '';
      _controller2.text = amountText ?? '';
      _numberController.text = contactText ?? '';
      print(documentData);
    });
  }

  //Format Name input
  String formatInput(String input) {
    List<String> words =
        input.split(' '); // split the input into individual words
    List<String> formattedWords = [];

    for (String word in words) {
      formattedWords.add(
          word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase());
    }

    return formattedWords
        .join(' '); // join the formatted words back into a single string
  }

  //Create new debtor
  void createNewDebtor({String? docId}) {
    showDialog(
        context: context,
        builder: (context) {
          if (docId != null) {
            _loadDocumentData(docId);
          }
          return AddDebtorDialog(
            controller: _controller,
            controller2: _controller2,
            numberController: _numberController,
            onSave: () {
              bool paid = false;
              if (docId == null) {
                //Formatting name input
                final String name = formatInput(_controller.text);
                //Creating a docId for both documenta
                final docId = FirebaseFirestore.instance
                    .collection('debtorsList')
                    .doc()
                    .id;

                fireStoreService.addDebtor(docId, name, _controller2.text,
                    _numberController.text, paid, _uid);
                fireStoreService.addDebtorHistory(docId, _controller.text,
                    _controller2.text, _numberController.text, paid, _uid);
              } else {
                //Updating
                fireStoreService.updateDebt(docId, _controller.text,
                    _controller2.text, _numberController.text, paid);
                fireStoreService.updateDebtHistory(docId, _controller.text,
                    _controller2.text, _numberController.text, paid);
              }
              _controller.clear();
              _controller2.clear();
              Navigator.pop(context);
            },
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //Delete debtor
  void deleteDebtor(int index) {
    setState(() {
      debtors.removeAt(index);
    });
  }

  //Debt Info
  void viewDebt() {
    showDialog(
        context: context,
        builder: (context) {
          return const ViewDebt();
        });
  }

//Get currently logged in user with UserID
  String? getUid() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: const Text(
          "Debts",
          style: TextStyle(
              fontFamily: "ClashGrotesk", fontWeight: FontWeight.w700),
        ),
        elevation: 1,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getDebtorsStream(getUid()),
        builder: (context, snapshot) {
          //if we have data get all the docs
          if (snapshot.hasData) {
            List debtorList = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                  itemCount: debtorList.length,
                  itemBuilder: (context, index) {
                    //get each doc
                    DocumentSnapshot document = debtorList[index];
                    String docId = document.id;

                    //get data from each doc
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    String nameText = data['name'];
                    String amountText = data['amount'];
                    String interestAmountText = data['interestAmount'];
                    bool paidValue = data['paid'];
                    String contact = data['contact'];

                    return DebtorTile(
                      name: nameText,
                      amount: amountText,
                      interestAmount: interestAmountText,
                      paid: paidValue,
                      docId: docId,
                      contact: contact,
                      deleteFunction: (context) =>
                          fireStoreService.deleteDebt(docId),
                      editFunction: (context) => createNewDebtor(docId: docId),
                      viewDebtFunction: (context) => viewDebt(),
                    );
                  }),
            );
          } else {
            return const Text("No data available yet...");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewDebtor(),
        backgroundColor: const Color.fromRGBO(235, 178, 255, 1),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.wallet),
            //   label: 'Wallet',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: const Color.fromRGBO(167, 254, 217, 1),
          unselectedItemColor: Colors.grey,
          onTap: _onTap),
    );
  }
}
