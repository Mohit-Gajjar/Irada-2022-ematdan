import 'package:ematdan/Pages/login.dart';
import 'package:ematdan/Pages/successfull.dart';
import 'package:flutter/material.dart';

class Booth extends StatelessWidget {
  const Booth({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xFF81E3EB),
       body: Stack(
         children: [
           Container(
             alignment: Alignment.topCenter,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
             child: SingleChildScrollView(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text("Create Voting Booth",style: TextStyle(fontSize: 15,color: Colors.black),),
                   const SizedBox(height: 20),
                     TextFormField(
                      // maxLines: 5,
                      decoration: InputDecoration(
                          labelText: 'Organisation Name  ',
                          // hintText: "Contact Number",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),),

                           const SizedBox(height: 20),
                     TextFormField(
                      // maxLines: 5,
                      decoration: InputDecoration(
                          labelText: 'Organiser Name',
                          // hintText: "Contact Number",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(600, 50),
                              primary: const Color(0xFF3D4660),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Successfull()));
                            },
                            child: const Text("Create")
                          )

                 ],
                 
               ),
             )
           )
         ],
       ),
      
    );
  }
}





                  