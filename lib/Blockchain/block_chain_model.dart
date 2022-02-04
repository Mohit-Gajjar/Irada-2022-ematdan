import 'dart:convert';

import 'package:ematdan/Services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class BlockChainModel extends ChangeNotifier {
  final String _rpcUrl = "http://192.168.0.109:7545";
  final String _wsUrl = "ws://192.168.0.109:7545/";

  final String privateKey =
      "fa32b105e7af499598ce85e28c39041ee8b9fbb91601646673a1f114c60c5312";

  BlockChainModel() {
    initialSetup();
  }

  Web3Client? _web3client;
  EthereumAddress? _contractAddress;
  DeployedContract? _contract;
  ContractFunction? _voteCandidate;
  ContractFunction? _getCandidateCount;
  ContractFunction? _addCandidates;
  ContractFunction? _winningCandidateName;
  // String partyName = " ";
  bool isLoading = true;
  BigInt? winnerIndex;
  String winningId = " ";
  String winnerCandidateName = " ";

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
    _getCandidateCount = _contract!.function("winningProposal");
    _voteCandidate = _contract!.function("vote");
    _addCandidates = _contract!.function("addCandidate");
    _winningCandidateName = _contract!.function("winnerName");
    isLoading = false;
    notifyListeners();
  }

  Future<void> getWinner() async {
    List winner = await _web3client!
        .call(contract: _contract!, function: _getCandidateCount!, params: []);
    print(winner[0]);
    winnerIndex = winner[0];
    List winnerName = await _web3client!.call(
        contract: _contract!, function: _winningCandidateName!, params: []);
    winnerCandidateName = winnerName[0];
    notifyListeners();
    // print(winnerCandidateName);
    isLoading = false;
    notifyListeners();
  }

  Future<void> addCandidates(String candidateName) async {
    isLoading = true;
    notifyListeners();
    print("Processing Tranansaction");
    await _web3client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!,
            function: _addCandidates!,
            parameters: [candidateName]));
    print("transaction completed");
    isLoading = false;
    notifyListeners();
  }

  Future<void> voteCandidate(BigInt id) async {
    isLoading = true;
    notifyListeners();
    print("Processing Tranansaction");

    await _web3client!.sendTransaction(
        _credentials!,
        Transaction.callContract(
            contract: _contract!, function: _voteCandidate!, parameters: [id]));
    isLoading = false;
    notifyListeners();
  }
}
