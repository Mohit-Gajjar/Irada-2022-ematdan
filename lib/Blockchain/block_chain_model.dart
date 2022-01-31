import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class BlockChainModel extends ChangeNotifier {
  final String _rpcUrl = "http://192.168.0.109:7545";
  final String _wsUrl = "ws://192.168.0.109:7545/";

  final String privateKey =
      "1aa32ab3a344a9a51b5e30c6c90e0e532f4aae62faa0e14a994d71435bf3e5b8";

  BlockChainModel() {
    initialSetup();
  }

  Web3Client? _web3client;
  EthereumAddress? _contractAddress, _ownAddress;
  DeployedContract? _contract;
  ContractFunction? _getVotes;
  ContractFunction? _getParty;
  ContractFunction? _vote;
  String partyName = " ";
  bool isLoading = true;
  BigInt? votes;
  // ignore: prefer_typing_uninitialized_variables
  var _abiCode;
  Credentials? _credentials;
  Future<void> initialSetup() async {
    _web3client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getCredentials();
    await getAbi();
    await getDeployedContract();
  }

  // ignore: prefer_typing_uninitialized_variables
  var jsonAbi;
  String abiStringFile = "";
  Future<void> getAbi() async {
    abiStringFile = await rootBundle.loadString("src/abis/Auth.json");
    jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    print(_contractAddress);
  }

  Future<void> getCredentials() async {
    // ignore: deprecated_member_use
    _credentials = await _web3client!.credentialsFromPrivateKey(privateKey);
    _ownAddress = await _credentials!.extractAddress();
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Auth"), _contractAddress!);
    _getParty = _contract!.function("getParty");
    _getVotes = _contract!.function("getVotes");
    _vote = _contract!.function("vote");
    getData();
    print(await _web3client!
        .call(contract: _contract!, function: _getVotes!, params: []));
  }

  Future<void> getData() async {
    List party = await _web3client!
        .call(contract: _contract!, function: _getParty!, params: []);
    partyName = party[0];
    print(party[0]);
    List count = await _web3client!
        .call(contract: _contract!, function: _getVotes!, params: []);
    print(count[0]);
    votes = count[0];
    isLoading = false;
    print("==============");
    notifyListeners();
  }

  Future<void> addVote(bool hasAuth, String partyName) async {
    isLoading = true;
    notifyListeners();
    print("---------------------");
    await _web3client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!,
            function: _vote!,
            parameters: [hasAuth, partyName]));
    getData();
  }
}
