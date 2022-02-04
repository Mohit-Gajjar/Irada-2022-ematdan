import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ematdan/Pages/Organiser/authenticate.dart';
import 'package:ematdan/Pages/Voter/parties.dart';
import 'package:ematdan/Services/authentication.dart';
import 'package:ematdan/Services/firebase.dart';
import 'package:ematdan/Services/local_database.dart';
import 'package:flutter/material.dart';

class VoterHome extends StatefulWidget {
  const VoterHome({Key? key}) : super(key: key);

  @override
  _VoterHomeState createState() => _VoterHomeState();
}

class _VoterHomeState extends State<VoterHome> {
  final formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  QuerySnapshot? snapshot;

  bool isLongPressed = false;
  Widget getBooths() {
    return snapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot!.docs.length,
            itemBuilder: (context, index) {
              return BoothTile(
                subtitle: snapshot!.docs[index]["organiser"],
                title: snapshot!.docs[index]["organisation"],
                id: snapshot!.docs[index]["boothId"],
              );
            })
        : Container();
  }

  getDataFunction() {
    Database().getBoothById(searchController.text).then((val) {
      setState(() {
        snapshot = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TextFormField(
            onFieldSubmitted: (val) => getDataFunction(),
            controller: searchController,
            decoration: InputDecoration(
                labelText: 'Search booth by Id',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
          ),
          actions: [
            IconButton(
                onPressed: getDataFunction,
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    AuthService().signOut();
                    LocalDatabase.saveVoterLoggedInState(false);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Authenticate()));
                  });
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ))
          ],
        ),
        body: getBooths());
  }
}

class BoothTile extends StatelessWidget {
  final String title, subtitle, id;
  const BoothTile(
      {Key? key, required this.title, required this.subtitle, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => VoterParties(boothId: id)));
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
