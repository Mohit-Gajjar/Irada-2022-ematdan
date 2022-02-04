import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Successfull extends StatelessWidget {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF81E3EB),
      body: Stack(
        children: [
          Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  
                     Lottie.network(
                      "https://assets5.lottiefiles.com/packages/lf20_gaxn5gzy.json",
                      repeat: false,
                      // controller: controller,
                    ),
                    Text("Vote Succed",style: TextStyle(color: Color(0xFF241F5E),fontSize: 26),),
                    Text("Thanks For \n     Voting ",style: TextStyle(color: Color(0xFF4A29CF),fontSize: 40))
                  
                ],
              ))
        ],
      ),
    );
  }
}
