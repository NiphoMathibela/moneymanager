import 'package:flutter/material.dart';
import 'package:moneymanager/pages/history_page.dart';
import 'package:moneymanager/pages/home_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  //Navigation functions
  int _currentIndex = 2;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Account", style: TextStyle(fontFamily: "ClashGrotesk", fontWeight: FontWeight.w600),),
        backgroundColor: Colors.white60,
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 245, 245, 1),
                  borderRadius: BorderRadius.circular(10)),
            
              //Email List tile
              child: const ListTile(
                leading: Icon(Icons.email),
                title: Text("Change email", style: TextStyle(fontFamily: "ClashGrotesk", fontWeight: FontWeight.w400),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 245, 245, 1),
                  borderRadius: BorderRadius.circular(10)),
            
              //Account List tile
              child: const ListTile(
                leading: Icon(Icons.key),
                title: Text("Change password", style: TextStyle(fontFamily: "ClashGrotesk", fontWeight: FontWeight.w400),),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
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
          currentIndex: _currentIndex,
          selectedItemColor: const Color.fromRGBO(167, 254, 217, 1),
          unselectedItemColor: Colors.grey,
          onTap: _onTap),
    );
  }
}
