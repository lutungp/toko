import 'package:flutter/material.dart';
import 'pages/Login.dart';
import 'pages/MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    LoginScreen.tag: (context) => LoginScreen(),
    MainPage.tag: (context) => MainPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        fontFamily: 'Nunito',
      ),
      home: LoginScreen(),
      routes: routes,
    );
  }
}