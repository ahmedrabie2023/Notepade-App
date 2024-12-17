import 'dart:async';
import 'package:flutter/material.dart';
import 'note_home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4,),
            () => Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const NoteHomeScreen();
          },
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              const Text("Notes",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.02,
              ),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.37,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.27,
                child: Image.asset("images/note1.png", fit: BoxFit.fill,),
              ),
            ],
          )
      ),
    );
  }
}

