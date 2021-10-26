import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/screens/login.dart';
import 'package:store/screens/phone_login.dart';
import 'package:store/screens/webScreen.dart';
import 'package:store/utility/share_pref.dart';
import 'package:store/utility/strings.dart';
import 'package:store/utility/theme.dart';
import 'screens/splesh.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({Key? key, required this.prefs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appNameStr,
      theme: ThemeData(
        primarySwatch: MyTheme.appColor,
      ),
      home: SplashScreen(),
    );
  }
}
