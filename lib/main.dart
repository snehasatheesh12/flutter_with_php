import 'package:flutter/material.dart';
import 'package:php_flutter/add.dart';
import 'package:php_flutter/home.dart';
import 'package:php_flutter/login.dart';
import 'package:php_flutter/register.dart';
import 'package:php_flutter/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>SplashScreen(),
        '/login':(context)=>LoginWidget(),
        '/home':(context)=>Homewidget(),
        '/add':(context)=>AddWidget(),
        '/register':(context)=>RegisterWidget(),

      },
    );
  }
}

