
import 'package:ematdan/Pages/Organiser/add_candidate.dart';
import 'package:ematdan/Services/firebase.dart';
import 'package:flutter/material.dart';

class Candidates extends StatefulWidget {
  final String id, name;
  const Candidates({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _CandidatesState createState() => _CandidatesState();
}

class _CandidatesState extends State<Candidates> {
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
                      title: snapshot.data.docs[index]["candidateName"],
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddCandidate(
                        boothId: widget.id,
                        partyName: widget.name,
                      )));
        },
      ),
    );
  }
}

class CandidateTile extends StatelessWidget {
  final String title, subtitle;
  const CandidateTile({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Text(title[0]),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
