import 'dart:html';

import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class BlockChain extends StatefulWidget {
  const BlockChain({Key? key}) : super(key: key);

  @override
  _BlockChainState createState() => _BlockChainState();
}

class _BlockChainState extends State<BlockChain> {
  late Client httpClient;
  late Web3Client ethClient;

  final myaddress = "0x1f7fB8022D571529cd6a8B012e47058F1db2B498";
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
