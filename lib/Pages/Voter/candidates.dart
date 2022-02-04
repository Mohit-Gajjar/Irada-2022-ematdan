import 'package:ematdan/Blockchain/block_chain_model.dart';
import 'package:ematdan/Services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VoterCandidates extends StatefulWidget {
  final String id, name;
  const VoterCandidates({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _VoterCandidatesState createState() => _VoterCandidatesState();
}

class _VoterCandidatesState extends State<VoterCandidates> {
  Stream? getCandidatesSteam;
  @override
  void initState() {
    getDataFunction();
    super.initState();
  }

  bool isLongPressed = false;
  Widget getCandidates() {
    return StreamBuilder(
        stream: getCandidatesSteam,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return CandidateTile(
                      subtitle: snapshot.data.docs[index]["partyName"],
                      title: snapshot.data.docs[index]["candidateName"], index: index,
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  getDataFunction() {
    Database().getCandidates(widget.id, widget.name).then((val) {
      getCandidatesSteam = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Candidates',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: getCandidates(),
    );
  }
}

class CandidateTile extends StatelessWidget {
  final String title, subtitle;
  final int index;
  const CandidateTile({Key? key, required this.title, required this.subtitle, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contractConnect = Provider.of<BlockChainModel>(context);
    return ListTile(
      onTap: () {
        print(index);
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Confirm Vote"),
            content: Text(title),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  await contractConnect.voteCandidate(BigInt.from(index));
                  Navigator.of(ctx).pop();
                },
                child: const Text("Vote"),
              ),
            ],
          ),
        );
      },
      leading: CircleAvatar(
        radius: 30,
        child: Text(title[0]),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
