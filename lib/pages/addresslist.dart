import 'package:blockpay/constants.dart';
import 'package:blockpay/controller/controller.dart';
import 'package:blockpay/pages/homepage.dart';
import 'package:blockpay/services.dart';
import 'package:blockpay/pages/transaction_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class MyListPage extends StatelessWidget {
  MyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Please verify all details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Index",
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Address",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Amount",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Remove",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Expanded(child: SingleChildScrollView(
                child: GetBuilder<Controller>(builder: (controller) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.list.length,
                itemBuilder: (context, index) {
                  var entry = controller.list.entries.toList()[index];
                  var key = entry.key;
                  var value = entry.value;
                  return Container(
                    height: height / 8,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width / 5,
                          child: Text(
                            "${index + 1} )",
                            style: const TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: width / 4,
                          child: Text(
                            key,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: width / 5,
                          child: Center(
                            child: Text(
                              value,
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          width: width / 4,
                          child: InkWell(
                            onTap: () {
                              controller.adddetails(key, "0");
                            },
                            child: const Center(
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }))),
          ],
        ),
      ),
      persistentFooterButtons: [
        GetBuilder<Controller>(
          builder: (controller) {
            return Container(
              color: Colors.black,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Addresses : ${controller.gettotaladdress()}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: height / 80,
                        ),
                        Text(
                          "Total Amount : ${controller.gettotalamount()}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        List<String> walletList =
                            controller.getwalletlist().cast<String>();
                        List<BigInt> amountList =
                            controller.getamountlist().cast<BigInt>();

                        transfer(walletList, amountList,
                                Web3Client(infura_url, Client()))
                            .then((transactionHashes) => {
                                  controller.checkTransactionStatus(
                                    Web3Client(infura_url, Client()),
                                    [transactionHashes],
                                  )
                                });

                        controller.checkTransactionStatus;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: height / 22,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text(
                          "SEND NOW",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyHomePage()));
                },
                child: const Icon(Icons.home_outlined)),
            label: 'Homepage',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lists',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TransactionHistory()));
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
