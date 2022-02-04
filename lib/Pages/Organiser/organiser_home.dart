
import 'package:ematdan/Pages/Organiser/addbooth.dart';
import 'package:ematdan/Pages/Organiser/authenticate.dart';
import 'package:ematdan/Pages/Organiser/parties.dart';
import 'package:ematdan/Services/authentication.dart';
import 'package:ematdan/Services/firebase.dart';
import 'package:ematdan/Services/local_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    return ListBooths(
                      subtitle: snapshot.data.docs[index]["organiser"],
                      title: snapshot.data.docs[index]["organisation"],
                      id: snapshot.data.docs[index]["boothId"],
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  getDataFunction() {
    Database().getBooth().then((val) {
      getBoothSteam = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booths',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
         actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    AuthService().signOut();
                    LocalDatabase.saveOrganiserLoggedInState(false);
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
      body: Container(
        child: getBooth(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddBooth())),
      ),
    );
  }
}

class ListBooths extends StatelessWidget {
  final String title, subtitle, id;
  const ListBooths(
      {Key? key, required this.title, required this.subtitle, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Clipboard.setData(ClipboardData(text: id)).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Booth Id copied to clipboard")));
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  Parties(boothId: id,)));
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
