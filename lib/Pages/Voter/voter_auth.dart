import 'package:ematdan/Pages/Voter/voter_home.dart';
import 'package:ematdan/Services/authentication.dart';
import 'package:ematdan/Services/local_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VoterAuth extends StatefulWidget {
  const VoterAuth({Key? key}) : super(key: key);

  @override
  _VoterAuthState createState() => _VoterAuthState();
}

// There is no user record corresponding to this identifier. The user may have been deleted.
class _VoterAuthState extends State<VoterAuth> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signin() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((val) {
          LocalDatabase.saveVoterLoggedInState(true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const VoterHome()));
        });
      } on FirebaseAuthException catch (e) {
        // print(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.code)));
      }
    }
  }

  signup() async {
    if (formKey.currentState!.validate()) {
      AuthService()
          .createVoterAcc(emailController.text, passwordController.text)
          .then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const VoterHome()));
        LocalDatabase.saveVoterLoggedInState(true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Authenticate',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        label: const Text("Enter Email"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        label: const Text("Enter Password"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          signin();
                        }
                      },
                      child: const Text("Authenticate")),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          signup();
                        }
                      },
                      child: const Text("Create"))
                ],
              ),
            ),
          ),
        ));
  }
}
