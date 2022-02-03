import 'package:flutter/material.dart';

class AddCandidates extends StatefulWidget {
  final String id, name;
  const AddCandidates({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _AddCandidatesState createState() => _AddCandidatesState();
}

class _AddCandidatesState extends State<AddCandidates> {
  deleteBooth(BuildContext context, String title, String id) {
    return;
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        //  onPressed:() {
        //        return showDialog(
        //             context: context,
        //             builder: (_) => AlertDialog(
        //                   title: const Text("Alert"),
        //                   content: Text('Delete Booth: ' + widget.name),
        //                   actions: [
        //                     TextButton(
        //                         onPressed: () {
        //                           Database().deleteBooth(widget.id).then(() {
        //                             ScaffoldMessenger.of(context).showSnackBar(
        //                                 SnackBar(
        //                                     content: Text(widget.name +
        //                                         " Booth Deleted")));
                                  
        //                           });
        //                         },
        //                         child: const Text(
        //                           'Confirm',
        //                           style: TextStyle(
        //                               decoration: TextDecoration.underline,
        //                               color: Colors.blue),
        //                         ))
        //                   ],
        //                 ));
      ),
    );
  }
}
