import 'package:ematdan/Services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/async.dart';

class AddParty extends StatefulWidget {
  final String boothId;
  const AddParty({Key? key, required this.boothId}) : super(key: key);

  @override
  _AddPartyState createState() => _AddPartyState();
}

class _AddPartyState extends State<AddParty> {
  final formKey = GlobalKey<FormState>();
  TextEditingController partyNameController = TextEditingController();
  TextEditingController candidateNameController = TextEditingController();
  final success = const SnackBar(content: Text('Party added'));
  String id = " ";
  generateId() async {
    id = await nanoid(10);
  }

  @override
  void initState() {
    generateId();
    super.initState();
  }

  addCandidate() async {
    if (formKey.currentState!.validate()) {
      generateId();
      Map<String, dynamic> data = {
        "partyName": partyNameController.text,
      };
      Database()
          .addParty(partyNameController.text, widget.boothId, data)
          .then((val) => ScaffoldMessenger.of(context).showSnackBar(success));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Party',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                TextFormField(
                  controller: partyNameController,
                  decoration: InputDecoration(
                      labelText: 'Party Name',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                ),
                
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (partyNameController.text.isNotEmpty ) {
                      addCandidate();
                      partyNameController.clear();
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
