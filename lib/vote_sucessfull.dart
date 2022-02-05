import 'package:ematdan/Pages/Voter/voter_home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'package:lottie/lottie.dart';

class Successfull extends StatelessWidget {
  const Successfull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Lottie.network(
              "https://assets1.lottiefiles.com/packages/lf20_axbanmfq.json",
              repeat: false,
            ),
            const Text(
              "Vote Successful",
              style: TextStyle(color: Color(0xFF241F5E), fontSize: 26),
            ),
            const Text("Thanks For Voting ",
                style: TextStyle(color: Color(0xFF4A29CF), fontSize: 40)),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const VoterHome())),
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
