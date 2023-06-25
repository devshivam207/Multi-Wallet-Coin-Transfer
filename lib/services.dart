import 'package:blockpay/constants.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadcontract() async {
  String abi = await rootBundle.loadString('constant/abi.json');
  String contractAddress = contract_address1;
  final contract = DeployedContract(ContractAbi.fromJson(abi, "CoinContract"),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callfunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey ceredentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadcontract();
  final ethfunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      ceredentials,
      Transaction.callContract(
        contract: contract,
        function: ethfunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}

Future<String> getBalance(String address, Web3Client ethClient) async {
  var response =
      await callfunction('getBalance', [address], ethClient, owner_pk);
  return response;
}

Future<String> transfer(
    List<String> wallets, List<BigInt> amounts, Web3Client ethClient) async {
  List<EthereumAddress> walletAddresses =
      wallets.map((wallet) => EthereumAddress.fromHex(wallet)).toList();

  var response = await callfunction(
      'transfer', [walletAddresses, amounts], ethClient, owner_pk);
  return response;
}
