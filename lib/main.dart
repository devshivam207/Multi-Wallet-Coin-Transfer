import 'package:blockpay/constants.dart';
import 'package:blockpay/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'controller/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => Controller());
    Client? httpClient;
    Web3Client? ethClient;

    void initState() {
      httpClient = Client();
      ethClient = Web3Client(infura_url, httpClient!);
    }

    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(),
    );
  }
}
