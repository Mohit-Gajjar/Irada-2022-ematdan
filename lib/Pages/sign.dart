import 'package:flutter/material.dart';

class Sign extends StatelessWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF35858B),
        body: Stack(
          children: [
            Container(
              margin:EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: const AssetImage("assets/images/v.png"),
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                    ),
                    const Text(
                      "E - Matdan",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Vote freely",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      // maxLines: 5,
                      decoration: InputDecoration(
                          labelText: 'Contact Number',
                          // hintText: "Contact Number",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      // maxLines: 5,
                      decoration: InputDecoration(
                          labelText: 'Aadhar Card Number',
                          // hintText: "Aadhar Card Number",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      // maxLines: 5,
                      decoration: InputDecoration(
                          labelText: 'Mail',
                          // hintText: "Enter Email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      // maxLines: 5,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          // hintText: "Enter Password",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(fixedSize: Size(600, 40),
                          primary: const Color(0xFF3D4660),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),

                        // ignore: avoid_print
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Sign()));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
