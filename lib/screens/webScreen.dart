import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/screens/login.dart';
import 'package:store/utility/share_pref.dart';
import 'package:store/utility/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WebScreen extends StatefulWidget {
  // final String? url;
  const WebScreen({Key? key}) : super(key: key);

  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final Completer<WebViewController> _webController =
      Completer<WebViewController>();
  bool loading = false;
  String? url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loading = false;
    });
    sharePref().whenComplete(() {
      setState(() {
        loading = true;
      });
    });
  }

  webViewCreate(WebViewController webViewController) {
    return (webViewController) => _webController.complete(webViewController);
  }

  Future sharePref() async {
    final instance = await SharedPreferences.getInstance();
    url = instance.getString(MySharedPref.url);
    // url =await sharedPrefsGet(instance, MySharedPref.url);
    if (url == null || url == '') {
      Fluttertoast.showToast(
          msg: "Missing URL",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade200,
          textColor: Colors.black,
          fontSize: 14.0);
    } else {
      /* Fluttertoast.showToast(
        msg: "$url",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green.shade200,
        textColor: Colors.black,
        fontSize: 14.0);*/
    }
    // print("meraurl =$url");
  }

  logout() async {
    final instance = await SharedPreferences.getInstance();
    instance.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Image appLogo = new Image(
      image: new ExactAssetImage("assets/appbaricon.png"),
      height: 60.0,
      width: 40.0,
      alignment: FractionalOffset.center);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          /*appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 60),
            child:Image.asset("assets/appbaricon.png",
                fit: BoxFit.fitHeight,
                alignment: FractionalOffset.center),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  logout();
                },
                child: Icon(Icons.logout)),
            SizedBox(width: 20)
          ],
        ),*/

          body: loading || _webController.isCompleted
              ? WebView(
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: webViewCreate,
                )
              : Center(child: CircularProgressIndicator()),
          /* floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.exit_to_app),
          ),*/
          // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
          /* bottomNavigationBar: _DemoBottomAppBar(
          fabLocation: FloatingActionButtonLocation.endDocked,
          shape:  const CircularNotchedRectangle(),
        ),*/
          bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).primaryColor,
            shape: CircularNotchedRectangle(),
            notchMargin: 5.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 30),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(webBottomTitle,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                  Spacer(),
                  GestureDetector(
                    child: Text("Logout",style: TextStyle(color: Colors.white, fontSize: 14),),
                    onTap: () {
                      logout();
                    },
                  ),
                ],
              ),
            ),

            // fabLocation: FloatingActionButtonLocation.endDocked,
          )
          // Text(webBottomTitle,textAlign: TextAlign.start),

          ),
    );
  }
}

