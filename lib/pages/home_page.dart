import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/pages/account_page.dart';
import 'package:moneymanager/pages/history_page.dart';
import 'package:moneymanager/services/firestore.dart';
import 'package:moneymanager/util/add_debtor.dart';
import 'package:moneymanager/util/debtors_tile.dart';

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

  //Create new debtor
  void createNewDebtor({String? docId}) {
    showDialog(
        context: context,
        builder: (context) {
          return AddDebtorDialog(
            controller: _controller,
            controller2: _controller2,
            numberController: _numberController,
            onSave: () {
              bool paid = false;
              if (docId == null) {
                fireStoreService.addDebtor(_controller.text, _controller2.text,
                    _numberController.text, paid);
              } else {
                fireStoreService.updateDebt(
                    docId, _controller.text, _controller2.text, paid);
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: const Text("Welcome!", style: TextStyle(fontFamily: "ClashGrotesk"),),
        elevation: 1,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getDebtorsStream(),
        builder: (context, snapshot) {
          //if we have data get all the docs
          if (snapshot.hasData) {
            List debtorList = snapshot.data!.docs;

            return ListView.builder(
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
                  bool paidValue = data['paid'];

                  return DebtorTile(
                    name: nameText,
                    amount: amountText,
                    paid: paidValue,
                    docId: docId,
                    deleteFunction: (context) =>
                        fireStoreService.deleteDebt(docId),
                    editFunction: (context) => createNewDebtor(docId: docId),
                  );
                });
          } else {
            return const Text("No data available yet...");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewDebtor(),
        backgroundColor: const Color.fromRGBO(235, 178, 255, 1),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
