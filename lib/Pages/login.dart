import 'package:ematdan/Pages/sign.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF35858B),
        body: Stack(
          children: [
            Container(
              margin:const EdgeInsets.symmetric(horizontal: 20),
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
                    const SizedBox(height: 5),
                    const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      // maxLines: 5,
                      decoration: InputDecoration(
                          // labelText: 'Email',
                          hintText: "Enter Your Email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      // maxLines: 5,
                      decoration: InputDecoration(
                          // labelText: 'Password',
                          hintText: "Enter Your Password",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize:const Size (600,40),
                      primary: const Color(0xFF3D4660),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),),
                    ),

                    // ignore: avoid_print
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Sign()));
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  
                    ),
                     const SizedBox(height: 5),
                    const Text(
                      "Or",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize:const Size (500,40),
                      primary: const Color(0xFF3D4660),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),),
                    ),

                    // ignore: avoid_print
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),

                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}


  //  SingleChildScrollView(
  //       child:Column(
  //         children:  [
  //           SizedBox(height: 20),
  //           Image(image: AssetImage("assets/images/v.png"),
  //           width: MediaQuery.of(context).size.width /3,
  //           )
  //           // Text("data",style: TextStyle(color:Colors.black),),
  //           // Image(image: AssetImage("assets/images/v.png"),
            
            
                          
            

  //         ],
  //       ),
  //     ),