import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:web3dart/web3dart.dart';

class Controller extends GetxController {
  Map<String, String> list = {};
  List<String> complete = [];
  List<String> failed = [];

  void adddetails(String address, String amount) {
    if (list.containsKey(address)) {
      list.update(address, (value) {
        return amount;
      });
      if (double.parse(amount) <= 0) {
        list.remove(address);
      }
    } else {
      if (double.parse(amount) > 0) {
        list.putIfAbsent(address, () {
          return amount;
        });
      }
    }
    update();
  }

  List<dynamic> getwalletlist() {
    return list.keys.toList();
  }

  List<BigInt> getamountlist() {
    List<BigInt> amounts = [];
    for (var entry in list.entries) {
      amounts.add(BigInt.parse(entry.value));
    }
    return amounts;
  }

  int gettotaladdress() {
    return list.length;
  }

  double gettotalamount() {
    double total = 0;
    for (var entry in list.entries) {
      total += double.parse(entry.value);
    }
    return total;
  }

  Future<void> checkTransactionStatus(
    Web3Client ethClient,
    List<String> transactionHashes,
  ) async {
    for (var hash in transactionHashes) {
      TransactionReceipt? receipt;
      do {
        receipt = await ethClient.getTransactionReceipt(hash);
        if (receipt == null) {
          await Future.delayed(const Duration(seconds: 1));
        }
      } while (receipt == null);

      if (receipt.status!) {
        print('Transaction $hash completed successfully.');
        complete.add(hash);
      } else {
        print('Transaction $hash failed.');
        failed.add(hash);
      }
    }
  }

  void updateTransactionHistory() {
    update();
  }
}
