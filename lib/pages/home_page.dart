import 'package:flutter/material.dart';
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

  //List of debtors
  List debtors = [
    ["J Swanson", "2000", false],
    ["Richie Rich", "1000", false],
    ["Eric Swanson", "2500", false],
  ];

  //Ceckbox tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      debtors[index][2] = !debtors[index][2];
    });
  }

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
  void createNewDebtor() {
    showDialog(
        context: context,
        builder: (context) {
          return AddDebtorDialog(
            controller: _controller,
            controller2: _controller2,
            onSave: saveNewDebtor,
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
        title: const Text("Welcome!"),
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: debtors.length,
          itemBuilder: (context, index) {
            return DebtorTile(
              name: debtors[index][0],
              amount: debtors[index][1],
              paid: debtors[index][2],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteDebtor(index),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewDebtor,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Color.fromRGBO(167, 254, 217, 1),
        unselectedItemColor: Colors.grey,
        onTap: (int index) => {
          // ignore: avoid_print
          print("selected index: $index")
        },
      ),
    );
  }
}
