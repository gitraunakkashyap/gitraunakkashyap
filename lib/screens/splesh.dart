import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/screens/homeDashboard.dart';
import 'package:store/screens/login.dart';
import 'package:store/utility/share_pref.dart';

import 'webScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var login;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading();
  }

  loading() async {
    final instance = await SharedPreferences.getInstance();
    print("hello");

    login = instance.getString(MySharedPref.login);
    // await get(Uri.parse("https://www.bedesistore.com/api/check-webview"));
    print(login);
    if (login != null || login == "true") {
      print("login===$login");
      Timer(
          Duration.zero,
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => dashboard())));
    } else {
      print("login===$login");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/splash.png"), fit: BoxFit.cover)),
          width: double.infinity,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ));
  }
}
