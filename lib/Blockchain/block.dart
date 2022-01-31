import 'package:ematdan/Blockchain/block_chain_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class BlockChain extends StatefulWidget {
  const BlockChain({Key? key}) : super(key: key);

  @override
  _BlockChainState createState() => _BlockChainState();
}

class _BlockChainState extends State<BlockChain> {
  @override
  Widget build(BuildContext context) {
    final contractConnect = Provider.of<BlockChainModel>(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Votes:\n" + contractConnect.votes.toString(),
          style: const TextStyle(fontSize: 30),
        ),
        Text(
          "Party Name:\n" + contractConnect.partyName.toString(),
          style: const TextStyle(fontSize: 30),
        ),
        ElevatedButton(
            onPressed: () async {
              await contractConnect.addVote(true, "BJP");
              setState(() {});
            },
            child: const Text(
              'Add Vote',
              style: TextStyle(fontSize: 30),
            )),
        //   ElevatedButton(
        // onPressed: () {},
        // child: const Text(
        //   'Get Vote',
        //   style: TextStyle(fontSize: 30),
        // )),
      ],
    ));
    // : const Center(
    //     child: CircularProgressIndicator(),
    //   );
  }
}
