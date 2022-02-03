import 'package:ematdan/Pages/google_sign.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sign extends StatelessWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF81E3EB),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                        width: MediaQuery.of(context).size.width / 3.5,
                      ),
                    ),
                    const Text(
                      "E - Matdan",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF0037A2),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Vote freely \n       & \n Securely",
                      style: TextStyle(fontSize: 15, color: Color(0xFF324E16)),
                    ),
                    const SizedBox(height: 10),

                    // TextFormField(
                    //   // maxLines: 5,
                    //   decoration: InputDecoration(
                    //       labelText: 'Contact Number',
                    //       // hintText: "Contact Number",
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(8.0),
                    //       )),
                    // ),
                    // const SizedBox(height: 5),
                    // TextFormField(
                    //   // maxLines: 5,
                    //   decoration: InputDecoration(
                    //       labelText: 'Aadhar Card Number',
                    //       // hintText: "Aadhar Card Number",
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(8.0),
                    //       )),
                    // ),
                    // const SizedBox(height: 5),
                    // TextFormField(
                    //   // maxLines: 5,
                    //   decoration: InputDecoration(
                    //       labelText: 'Mail',
                    //       // hintText: "Enter Email",
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(8.0),
                    //       )),
                    // ),
                    // const SizedBox(height: 5),
                    // TextFormField(
                    //   // maxLines: 5,
                    //   decoration: InputDecoration(
                    //       labelText: 'Password',
                    //       // hintText: "Enter Password",
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(8.0),
                    //       )),
                    // ),
                    const SizedBox(height: 50),
                    Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(180, 150),
                                primary: const Color(0xFF81E3EB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                               final provider =Provider.of<GoogleSignInProvider>(context,listen: false);
                               provider.googleLogin();
                              },
                              child: const Image(
                                  image:
                                      AssetImage("assets/images/google.png")),
                            ),
                            Text("Sign In"),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
