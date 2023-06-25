import 'package:blockpay/pages/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'addresslist.dart';
import '../controller/controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    final Controller controller = Get.find<Controller>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black54,
        title: const Text(
          "Welcome  To  XTransfer",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            height: height / 2.5,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 246, 85),
                borderRadius: BorderRadius.circular(40)),
            child: Column(
              children: [
                SizedBox(
                  height: height / 25,
                ),
                Container(
                  width: width / 1.5,
                  height: height / 20,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text(
                      "Enter Wallet Address",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.wallet),
                        labelText: 'Wallet Address',
                        labelStyle: TextStyle(color: Colors.black)),
                    onChanged: (value) {
                      // any condition
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: amountController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.money_rounded),
                        labelText: 'Enter Amount',
                        labelStyle: TextStyle(color: Colors.black)),
                    onChanged: (value) {
                      // any condition
                    },
                  ),
                ),
                SizedBox(
                  height: height / 20,
                ),
                InkWell(
                  onTap: () {
                    controller.adddetails(
                        addressController.text, amountController.text);
                  },
                  child: Container(
                    width: width / 4,
                    height: height / 15,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40)),
                    child: const Center(
                        child: Text(
                      "ADD",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black54,
        items: [
          const BottomNavigationBarItem(
            icon: InkWell(child: Icon(Icons.home_outlined)),
            label: 'Homepage',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyListPage()));
                },
                child: const Icon(Icons.list)),
            label: 'Lists',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TransactionHistory()));
                },
                child: const Icon(Icons.history)),
            label: 'History',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
