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
    // getDataFunction();
    getData();
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  String candidateName = " ";
  getData() async {
    candidateName = await Database().getCandidateName(widget.id, widget.name);
    setState(() {});
  }

  Future<void> vote() async {
    Map<String, dynamic> data = {"voted": true};
    Database().addVotedUser(data, user!.uid).then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Successfull()));
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
          : Column(
              children: [
                Center(
                  child: Text(
                    "Party Name: " + widget.name,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                Center(
                  child: Text(
                    "Candidate Name: " + candidateName,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (ctx) => contractConnect.isLoading
                        ? const Center(
                            child:
                                Text("Please Wait, Transaction Processing..."),
                          )
                        : AlertDialog(
                            title: const Text("Confirm Vote"),
                            content: Text(candidateName),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  await contractConnect
                                      .voteCandidate(BigInt.from(0));
                                  print("Vote Complete");
                                  vote();
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Vote"),
                              ),
                            ],
                          ),
                  ),
                  child: const CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.touch_app_outlined,
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class CandidateTile extends StatefulWidget {
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
  State<CandidateTile> createState() => _CandidateTileState();
}

class _CandidateTileState extends State<CandidateTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Text(widget.title[0]),
      ),
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
    );
  }
}
