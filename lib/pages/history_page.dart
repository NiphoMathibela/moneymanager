import 'package:flutter/material.dart';
import 'package:moneymanager/pages/home_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //Navigation functions
  int _currentIndex = 1;

  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
  ];

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
        title: const Text("History"),
        elevation: 1,
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // space the containers evenly

            children: [
              Container(
                height: 140, // adjust the height as needed

                width: 160, // adjust the width as needed

                // background color of the container

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(235, 178, 255, 1),
                ),

                //Container content
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.work),
                      Text("Recieved"),
                      Text("R 15,000.00")
                    ],
                  ),
                ),
              ),
              Container(
                height: 140, // adjust the height as needed

                width: 160, // adjust the width as needed

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(167, 254, 217, 1),
                ),

                //Container content
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.payment_rounded),
                      Text("Amount loaned"),
                      Text("R 15,000.00")
                    ],
                  ),
                ),
              ),
            ]),
      )),
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
          currentIndex: _currentIndex,
          selectedItemColor: const Color.fromRGBO(167, 254, 217, 1),
          unselectedItemColor: Colors.grey,
          onTap: _onTap),
    );
  }
}
