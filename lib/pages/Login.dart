import 'package:flutter/material.dart';
import 'package:mystore/pages/MainPage.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
// import 'package:crypto/crypto.dart' as crypto;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  bool _isInAsyncCall = false;
  bool _isLoggedIn = false;

  final userloginCtrl = TextEditingController(text: "");
  final passwordloginCtrl = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/logo.png'),
      ),
    );

    final username = TextFormField(
      controller: userloginCtrl,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      validator: (value) {
        if (value.length < 6)
          return 'Minimal 6 karakter';
        else
          return null;
      },
    );

    final password = TextFormField(
      controller: passwordloginCtrl,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        // elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () => _login(),
          color: Colors.green,
          child: Text('Masuk', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final titleLogin = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Admin ',
          style: TextStyle(color: Colors.redAccent, fontSize: 16.0),
          children: <TextSpan>[
            TextSpan(
              text: ' RS HAJI JAKARTA',
              style: TextStyle(color: Colors.green, fontSize: 16),
            )
          ]),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            titleLogin,
            SizedBox(height: 15.0),
            username,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
          ],
        ),
      ),
    );
  }

  Future<dynamic> _login() async {
    /*
    final JsonDecoder _decoder = new JsonDecoder();
    try {
      var user = new Utf8Encoder().convert(userloginCtrl.text);
      var md5 = crypto.md5;
      var key = md5.convert(user);
      var url = "http://10.0.2.2/slim-api/public/auth/login/?key=${key}";
      final response = await http
          .post(url,
                body: {
                  'username': userloginCtrl.text, 
                  'password': passwordloginCtrl.text
          });
      if (response.statusCode < 200 || response.statusCode > 300) {
        setState(() {
          _isInAsyncCall = false;
        });
        setState(() {
            _isInAsyncCall = false;
            showDialog(
                context: context,
                builder: (_) =>
                new AlertDialog(
                  content: new Text("Username atau password salah"),
                ));
          });
      } else {
        var datauser = _decoder.convert(response.body);
        if (datauser["status"]=="error") {
          setState(() {
            _isInAsyncCall = false;
            showDialog(
                context: context,
                builder: (_) =>
                new AlertDialog(
                  content: new Text("Username atau password salah"),
                ));
          });
        } else {*/
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('user_id', "0");
      prefs.setString('user_kode', "A");
      prefs.setString('user_nama', "A");
      prefs.setString('user_apikey', "A");
      Navigator.of(context).pushNamed(MainPage.tag);
      _isInAsyncCall = false;
    });
    /*}
      }
    } catch (e) {
      _isInAsyncCall = false;
      print(e);
      showDialog(
          context: context,
          builder: (_) =>
          new AlertDialog(
            content: new Text("Tidak terhubung dengan server"),
          ));
      setState(() {
        _isInAsyncCall = false;
      });
      return null;
    }*/
  }

  getCredential() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("user_id"));
    setState(() {
      if (prefs.getString("user_id") != null) {
        _isLoggedIn = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => new MainPage()),
        );
      } else {
        _isLoggedIn = false;
      }
    });
  }
}
