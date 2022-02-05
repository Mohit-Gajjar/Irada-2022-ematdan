import 'package:ematdan/Blockchain/block_chain_model.dart';
import 'package:ematdan/Pages/Voter/voter_home.dart';
import 'package:ematdan/Services/local_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/Organiser/authenticate.dart';
import 'Pages/Organiser/organiser_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool organiserIsLoggedIn = false, voterIsLoggedIn = false;
  @override
  void initState() {
    checkLoggedInStatus();
    super.initState();
  }

  void checkLoggedInStatus() async {
    await LocalDatabase.getOrganiserSharedPrefs().then((value) {
      if (value == true) {
        setState(() {
          organiserIsLoggedIn = true;
        });
      } else if (value == false && value == null) {
        setState(() {
          organiserIsLoggedIn = false;
        });
      }
    });
    await LocalDatabase.getVoterSharedPrefs().then((value) {
      if (value == true) {
        setState(() {
          voterIsLoggedIn = true;
        });
      } else if (value == false && value == null) {
        setState(() {
          voterIsLoggedIn = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => BlockChainModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-matdan',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: organiserIsLoggedIn
              ? const HomePage()
              : voterIsLoggedIn
                  ? const VoterHome()
                  : const Authenticate()));
}
