import 'package:ematdan/Pages/booth.dart';
import 'package:ematdan/Pages/sign.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
                    Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(180, 150),
                                primary: const Color(0xFF4CB8CF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Sign()));
                              },
                              child: const Image(
                                  image: AssetImage("assets/images/vv.png")),
                            ),
                            Text("Voter"),
                          ],
                        )),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(180, 150),
                              primary: const Color(0xFF4CB8CF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Booth()));
                            },
                            child: const Image(
                                image:
                                    const AssetImage("assets/images/org.png")),
                          ),
                          Text("Organiser"),
                        ],
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
