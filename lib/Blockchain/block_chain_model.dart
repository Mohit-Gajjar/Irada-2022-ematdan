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
      "59e601b43442e966bd5d4e59bf391f64e9371342a7c6332ffd611f24a0b08200";

  BlockChainModel() {
    initialSetup();
  }

  Web3Client? _web3client;
  EthereumAddress? _contractAddress;
  DeployedContract? _contract;
  ContractFunction? _getWinningCandidate;
  // ContractFunction? _getParty;
  ContractFunction? _addCandidates;
  // String partyName = " ";
  bool isLoading = true;
  String? winnerName;
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
    print("Contract Address: " + _contractAddress.toString());
  }

  Future<void> getCredentials() async {
    // ignore: deprecated_member_use
    _credentials = await _web3client!.credentialsFromPrivateKey(privateKey);
    // _ownAddress = await _credentials!.extractAddress();
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Auth"), _contractAddress!);
    // _getParty = _contract!.function("getParty");
    _getWinningCandidate = _contract!.function("winnerName");
    _addCandidates = _contract!.function("getProposals");
    getData();
    print(await _web3client!.call(
        contract: _contract!, function: _getWinningCandidate!, params: []));
  }

  Future<void> getData() async {
    // List party = await _web3client!
    //     .call(contract: _contract!, function: _getParty!, params: []);
    // partyName = party[0];
    // print(party[0]);
    List winner = await _web3client!.call(
        contract: _contract!, function: _getWinningCandidate!, params: []);
    print(winner[0]);
    winnerName = winner[0];
    isLoading = false;
    print("==============");
    notifyListeners();
  }

  Future<void> addCandidates() async {
    isLoading = true;
    notifyListeners();
    print("---------------------");
    await _web3client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!,
            function: _addCandidates!,
            parameters: [  '0x9b763C830d5AE28253F661f5758c7Dff82cA5f3A',
                     ' 0xb2Cd5845e3725e72407DA9F1159D53A319F32F5f',
                     ' 0x957c0F58A24D58e4726CE7b3B2eda5279A462eD4']));
    getData();
  }
}
