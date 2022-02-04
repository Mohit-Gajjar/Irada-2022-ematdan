import 'package:ematdan/Pages/Voter/candidates.dart';
import 'package:ematdan/Services/firebase.dart';
import 'package:flutter/material.dart';

class VoterParties extends StatefulWidget {
  final String boothId;
  const VoterParties({Key? key, required this.boothId}) : super(key: key);

  @override
  _VoterPartiesState createState() => _VoterPartiesState();
}

class _VoterPartiesState extends State<VoterParties> {
  Stream? getBoothSteam;
  @override
  void initState() {
    getDataFunction();
    super.initState();
  }

  bool isLongPressed = false;
  Widget getBooth() {
    return StreamBuilder(
        stream: getBoothSteam,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return PartyTile(
                      partyName: snapshot.data.docs[index]["partyName"],
                      id: widget.boothId,
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  getDataFunction() {
    Database().getParties(widget.boothId).then((val) {
      getBoothSteam = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Parties',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: getBooth(),
      
    );
  }
}

class PartyTile extends StatelessWidget {
  final String partyName, id;
  const PartyTile({Key? key, required this.partyName, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VoterCandidates(
                    name: partyName,
                    id: id,
                  ))),
      leading: CircleAvatar(
        child: Text(partyName[0]),
      ),
      title: Text(partyName),
    );
  }
}
