import 'package:ematdan/Pages/Voter/voter_auth.dart';
import 'package:ematdan/Pages/organiser_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  AuthenticateState createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
        const SizedBox(height: 30),
        InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OrganiserAuth())),
          child: const CircleAvatar(
            radius: 100,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/org.png'),
          ),
        ),
        const Text(
          "Organiser",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 30),
        InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const VoterAuth())),
          child: const CircleAvatar(
            radius: 100,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/vv.png'),
          ),
        ),
        const Text(
          "Voter",
          style: TextStyle(fontSize: 24),
        ),
      ],
    ));
  }
}
