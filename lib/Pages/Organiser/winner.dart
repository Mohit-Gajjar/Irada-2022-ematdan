import 'package:ematdan/Blockchain/block_chain_model.dart';
import 'package:ematdan/Services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WinnerCalCulation extends StatefulWidget {
  const WinnerCalCulation({Key? key}) : super(key: key);

  @override
  _WinnerCalCulationState createState() => _WinnerCalCulationState();
}

class _WinnerCalCulationState extends State<WinnerCalCulation> {
  void getData(String id) async {
    name = (await Database().winnerName(id))!;
  }

  String name = " ";
  String id = " ";
  @override
  Widget build(BuildContext context) {
    final contractConnect = Provider.of<BlockChainModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Winner Calculation',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          // Center(
          //   child: Text("Winner Name: " + name),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Center(
            child: Text("Winner Id: " + contractConnect.winnerCandidateName),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                // id = contractConnect.winnerCandidateName;
                // print("Winnerid: " + id);
                // setState(() {});
                await contractConnect.getWinner();
              },
              child: const Text("Get Winner"))
        ],
      ),
    );
  }
}
