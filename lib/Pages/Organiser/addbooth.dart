import 'package:ematdan/Services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/async.dart';

class AddBooth extends StatefulWidget {
  const AddBooth({Key? key}) : super(key: key);

  @override
  _AddBoothState createState() => _AddBoothState();
}

class _AddBoothState extends State<AddBooth> {
  final formKey = GlobalKey<FormState>();
  TextEditingController organiserNameController = TextEditingController();
  TextEditingController organisationNameController = TextEditingController();
  final success = const SnackBar(content: Text('Booth Created'));
  String id = " ";
  generateId() async {
    id = await nanoid(10);
  }

  @override
  void initState() {
    generateId();
    super.initState();
  }

  addBooth() async {
    if (formKey.currentState!.validate()) {
      generateId();
      Map<String, dynamic> data = {
        "organiser": organiserNameController.text,
        "organisation": organisationNameController.text,
        "boothId": id,
        "over": null
      };
      Database()
          .addBooth(data, id)
          .then((val) => ScaffoldMessenger.of(context).showSnackBar(success));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Booth',
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
                  controller: organisationNameController,
                  decoration: InputDecoration(
                      labelText: 'Organisation Name',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: organiserNameController,
                  decoration: InputDecoration(
                      labelText: 'Organiser Name',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (organisationNameController.text.isNotEmpty &&
                        organiserNameController.text.isNotEmpty) {
                      addBooth();
                      organisationNameController.clear();
                      organiserNameController.clear();
                    }
                  },
                  child: const Text("create"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
