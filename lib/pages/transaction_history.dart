import 'package:blockpay/controller/controller.dart';
import 'package:blockpay/pages/addresslist.dart';
import 'package:blockpay/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const duration = Duration(seconds: 2);
    _timer = Timer.periodic(duration, (_) {
      final controller = Get.find<Controller>();
      controller.updateTransactionHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History "),
      ),
      body: Container(
        color: Colors.black,
        child: GetBuilder<Controller>(
          builder: (controller) {
            List<String> completeList = controller.complete;
            List<String> failedList = controller.failed;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: completeList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Transaction Complete",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                              left: 40,
                              right: 40,
                            ),
                            child: Text(
                              "${index + 1}) ${completeList[index]}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: failedList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Transaction Failed",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                              left: 40,
                              right: 40,
                            ),
                            child: Text(
                              "${index + 1}) ${failedList[index]}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
              child: const Icon(Icons.home_outlined),
            ),
            label: 'Homepage',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyListPage()),
                );
              },
              child: const Icon(Icons.list),
            ),
            label: 'Lists',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
