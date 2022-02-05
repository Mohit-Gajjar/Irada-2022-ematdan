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
      "4572158d34925e69cc3d3b98a5221224128b861328d289a3fd50335aedc8bc2e";

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

  Future<String> getWinner() async {
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
    return winnerCandidateName;
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
