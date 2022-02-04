import 'package:ematdan/Blockchain/block_chain_model.dart';
import 'package:ematdan/Services/firebase.dart';
import 'package:ematdan/vote_sucessfull.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? user;
  @override
  void initState() {
    getDataFunction();
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    print(user!.uid);
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
                      title: snapshot.data.docs[index]["candidateName"],
                      index: index,
                      userId: user!.uid,
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
    final contractConnect = Provider.of<BlockChainModel>(context);

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
      body: contractConnect.isLoading
          ? const Center(
              child: Text("Please Wait, Transaction Processing..."),
            )
          : getCandidates(),
    );
  }
}

class CandidateTile extends StatelessWidget {
  final String title, subtitle, userId;
  final int index;
  const CandidateTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.index,
      required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contractConnect = Provider.of<BlockChainModel>(context);
    vote() async {
      await contractConnect.voteCandidate(BigInt.from(index));
      print("Vote Complete");
      Map<String, dynamic> data = {"voted": true};
      Database().addVotedUser(data, userId).then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Successfull()));
      });
    }

    return ListTile(
      onTap: () {
        print(index);
        showDialog(
          context: context,
          builder: (ctx) => contractConnect.isLoading
              ? const Center(
                  child: Text('Please Wait, Processing transaction...'),
                )
              : AlertDialog(
                  title: const Text("Confirm Vote"),
                  content: Text(title),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        vote();
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