import 'package:ematdan/Blockchain/block_chain_model.dart';
import 'package:ematdan/Services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/async.dart';
import 'package:provider/provider.dart';

class AddCandidate extends StatefulWidget {
  final String boothId, partyName;
  const AddCandidate({Key? key, required this.boothId, required this.partyName})
      : super(key: key);

  @override
  _AddCandidateState createState() => _AddCandidateState();
}

class _AddCandidateState extends State<AddCandidate> {
  final formKey = GlobalKey<FormState>();
  TextEditingController candidateNameController = TextEditingController();
  TextEditingController partyNameController = TextEditingController();
  final success = const SnackBar(content: Text('Candidate added'));
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
        "candidateName": candidateNameController.text,
        "partyName": widget.partyName,
        "id": id
      };
      Database()
          .addCandidate(data, widget.boothId, id, widget.partyName)
          .then((val) {
        ScaffoldMessenger.of(context).showSnackBar(success);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final contractConnect = Provider.of<BlockChainModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Candidate Info',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: contractConnect.isLoading
          ? const Center(
              child: Text("Processing Transaction, Please wait....."))
          : Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: candidateNameController,
                        decoration: InputDecoration(
                            labelText: 'Candidate Name',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (candidateNameController.text.isNotEmpty) {
                            addCandidate();
                            await contractConnect.addCandidates(id);
                            candidateNameController.clear();
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
