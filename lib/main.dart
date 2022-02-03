import 'package:ematdan/Blockchain/block.dart';
import 'package:ematdan/Blockchain/block_chain_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BlockChainModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'E-Matdan',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Root()),
    );
  }
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return const BlockChain();
  }
}
