import 'package:ematdan/Blockchain/block_chain_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlockChain extends StatefulWidget {
  const BlockChain({Key? key}) : super(key: key);

  @override
  _BlockChainState createState() => _BlockChainState();
}

class _BlockChainState extends State<BlockChain> {
  @override
  Widget build(BuildContext context) {
    final contractConnect = Provider.of<BlockChainModel>(context);
    return contractConnect.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Winner: " + contractConnect.winnerName!,
                style: const TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await contractConnect.addCandidates();
                    setState(() {});
                  },
                  child: const Text(
                    'Add Candidates',
                    style: TextStyle(fontSize: 30),
                  )),
            ],
          ));
  }
}
