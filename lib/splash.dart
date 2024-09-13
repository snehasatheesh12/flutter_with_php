import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToNextScreen();
     super.initState();
  }

  Future<void>_navigateToNextScreen() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    bool isLoggedIn =prefs.getBool('isLoggedIn') ?? false;
    await Future.delayed(const Duration(seconds: 3));

    if(isLoggedIn){
      Navigator.pushReplacementNamed(context, '/home');

    }
    else{
      Navigator.pushReplacementNamed(context,'/');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SafeArea(child: Column(children: [
        Center(child: Text("heloo welcome",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),))
      ],),),
    );
  }
}
