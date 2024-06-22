import 'package:flutter/material.dart';
import 'package:moneymanager/pages/account_page.dart';
import 'package:moneymanager/pages/home_page.dart';
import 'package:moneymanager/services/firestore.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //Access firestore
  final FireStoreService fireStoreService = FireStoreService();

  //Page values
  double _owedFuture = 0;
  double _recievedFuture = 0;

  @override
  void initState() {
    super.initState();
    _calculateSum();
  }

  Future<void> _calculateSum() async {
    final sum = await fireStoreService.calculateSum();
    final paid = await fireStoreService.calculatePaid();

    setState(() {
      _owedFuture = sum;
      _recievedFuture = paid;
    });
  }

  //   Future<void> _calculatePaid() async {
  //   final sum = await fireStoreService.calculateSum();
  //   final paid = await fireStoreService.calculatePaid();

  //   setState(() {
  //     _owedFuture = sum;
  //     _recievedFuture = paid;
  //   });
  // }

  //Navigation functions
  int _currentIndex = 1;

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
        title: const Text(
          "History",
          style: TextStyle(
              fontFamily: "ClashGrotesk", fontWeight: FontWeight.w700),
        ),
        elevation: 1,
      ),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // space the containers evenly

            children: [
              Expanded(
                child: Container(
                  height: 140, // adjust the height as needed

                  // width: 160, // adjust the width as needed

                  // background color of the container

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(235, 178, 255, 1),
                  ),

                  //Container content
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.work),
                        const Text(
                          "Recieved",
                          style: TextStyle(
                              fontFamily: "ClashGrotesk",
                              fontSize: 15,
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "R $_recievedFuture",
                          style: const TextStyle(
                              fontFamily: "ClashGrotesk",
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 140, // adjust the height as needed

                  // width: 160, // adjust the width as needed

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(167, 254, 217, 1),
                  ),

                  //Container content
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.payment_rounded),
                        const Text(
                          "Loaned",
                          style: TextStyle(
                              fontFamily: "ClashGrotesk",
                              fontSize: 15,
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "R $_owedFuture",
                          style: const TextStyle(
                              fontFamily: "ClashGrotesk",
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
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
