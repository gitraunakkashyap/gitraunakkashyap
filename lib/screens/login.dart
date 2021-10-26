import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/screens/homeDashboard.dart';
import 'package:store/screens/phone_login.dart';
import 'package:store/screens/webScreen.dart';
import 'package:store/utility/share_pref.dart';
import 'package:store/utility/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController _emailController = TextEditingController(text: "deepakbishnoi0108@gmail.com");
  // TextEditingController _passwordController = TextEditingController(text: "admin1234");
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn gSignIn = GoogleSignIn();
  var facebookLogin = FacebookLogin();
  String? _token;
  FacebookUserProfile? _profile;
  String? _email;
  String? _imageUrl;
  String? _userId;
  String? _name;
  String? _platform;

  // LoginModel? loginData;
  bool isLoading = true;
  bool loginButton = false;
  bool obscureText = true;
  bool isLoginSocial = false;

  Future<void> _onPressedExpressLogInButton(BuildContext context) async {
    isLoginSocial=true;
    var res;
    res = await facebookLogin.logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile,
    ]);
    if (res == Null) {
      res = await facebookLogin.expressLogin();
    }
    // final a = res as FacebookLoginResult;
    print("response wala==${res.error}");
    print("res==$res");
    if (res.status == FacebookLoginStatus.success) {
      setState(() {
        isLoginSocial = false;
      });
      await _updateLoginInfo();
    } else {
      isLoginSocial = false;
      Fluttertoast.showToast(
          msg: res.error==null?"Error with Facebook Login":"${res.error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade200,
          textColor: Colors.black,
          fontSize: 14.0);
      /* await showDialog<Object>(
        context: context,
        builder: (context) =>
        const AlertDialog(
          content: Text("Can't Login Right Now."),
        ),
      );*/
    }
  }

  Future<void> _updateLoginInfo() async {
    final plugin = facebookLogin;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      _userId = token.userId;
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    }
    // switch (token!.token.isNotEmpty) {
    //   case FacebookLoginStatus.error:
    //     onLoginStatusChanged(false);
    //     break;
    //   case FacebookLoginStatus.cancel:
    //     onLoginStatusChanged(false);
    //     break;
    //   case FacebookLoginStatus.success:
    var graphResponse = await get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=$_token'));

    var profiley = json.decode(graphResponse.body);
    print(profiley.toString());

    // onLoginStatusChanged(true, profileData: profile);
    // break;
    // }
    setState(() {
      // _token = token ;
      _name = profile!.name;
      _profile = profile;
      _email = email;
      _imageUrl = imageUrl;
      _platform = "facebook";
      isLoginSocial = true;
    });

    // print("facebook token==${_token!.token}");
    print("facebook userId==$_userId");
    print("facebook name==$_name");
    print("facebook profile==$_profile");
    print("facebook email==$_email");
    print("facebook imageUrl==$_imageUrl");
    if (_userId == null) {
      return;
    }

    plugin.logOut();
  }

  googleSignIn(BuildContext context) {
    setState(() {
      isLoginSocial = true;
    });
    gSignIn.signIn().then((GoogleSignInAccount? result) {
      result!.authentication.then((googleKey) async {
        isLoginSocial = false;
        print("googleKey.accessToken==${googleKey.accessToken}");
        print("googleKey.idToken==${googleKey.idToken}");
        print(
            "gSignIn.currentUser!.displayName==${gSignIn.currentUser!.displayName}");
        print("gSignIn.currentUser!.email==${gSignIn.currentUser!.email}");
        print(
            "gSignIn.currentUser!.photoUrl==${gSignIn.currentUser!.photoUrl}");
        print('gID--------${gSignIn.currentUser!.id}');
        setState(() {
          _userId = gSignIn.currentUser!.id;
          _name = gSignIn.currentUser!.displayName;
          _platform = "google";
          // _profile = profile;
          _email = gSignIn.currentUser!.email;
          _imageUrl = gSignIn.currentUser!.photoUrl;
          isLoginSocial = false;
        });
        //104628453702524585814
        if (_userId != null || _userId != "") {
          signup().whenComplete(() => setState(() {
                isLoginSocial = false;
              }));
        }
        gSignIn.signOut();
      }).catchError((err) {
        setState(() {
          isLoginSocial = false;
        });
        print(err);
      });
    }).catchError((err) {
      print('----$err');
      print('error occured');
      setState(() {
        isLoginSocial = false;
      });
    }).whenComplete(() => setState(() {
          isLoginSocial = false;
        }));
  }

  void fbSignOut(String token) async {
    await facebookLogin.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.green.shade100,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Image.asset(
                      appLogoImage,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.person,
                              color: Theme.of(context).primaryColor),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                          hintText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _passwordController,
                        obscureText: obscureText,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key,
                              color: Theme.of(context).primaryColor),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(
                                !obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _registrationLaunchURL();
                              },
                              child: Text(registerStr)),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                _forgetLaunchURL();
                              },
                              child: Text(forgetStr)),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                /* loginButton
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_emailController.text)) {
                              print("email is Invalid");
                              Fluttertoast.showToast(
                                  msg: "email is Invalid",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green.shade200,
                                  textColor: Colors.black,
                                  fontSize: 14.0);
                              return;
                            }
                            if (_passwordController.text.length < 6) {
                              print("email is Invalid");
                              Fluttertoast.showToast(
                                  msg: "password is Invalid",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green.shade200,
                                  textColor: Colors.black,
                                  fontSize: 14.0);
                              return;
                            }
                            emailLogin();
                          },
                          child: Container(
                            child: Text(
                              loginStr,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            width: double.infinity,
                            height: kToolbarHeight,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),*/
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailController.text)) {
                      print("email is Invalid");
                      Fluttertoast.showToast(
                          msg: emailStr+invalidStr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green.shade200,
                          textColor: Colors.black,
                          fontSize: 14.0);
                      return;
                    }
                    if (_passwordController.text.length < 6) {
                      print("password is Invalid");
                      Fluttertoast.showToast(
                          msg: passwordStr+invalidStr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green.shade200,
                          textColor: Colors.black,
                          fontSize: 14.0);
                      return;
                    }
                    if (loginButton==true) {
                      print(waitStr);
                      Fluttertoast.showToast(
                          msg: waitStr,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green.shade200,
                          textColor: Colors.black,
                          fontSize: 14.0);
                      return;
                    }

                    emailLogin();
                  },
                  child: loginButton?CircularProgressIndicator(color: Colors.white,):Text(
                    loginStr,
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white, fontSize: 20),
                      shape: StadiumBorder(),
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                          kToolbarHeight)),
                ),
                SizedBox(height: 10),
                Text(orStr,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                SizedBox(height: 10),
               /* Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => PhoneLogin())),
                    child: Container(
                      child: Text(
                        loginWithPhoneStr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      width: double.infinity,
                      height: kToolbarHeight,
                      alignment: Alignment.center,
                    ),
                  ),
                ),*/
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PhoneLogin())),
                  child: Text(
                    loginWithPhoneStr,
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white, fontSize: 20),
                      shape: StadiumBorder(),
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                          kToolbarHeight)),
                ),
                SizedBox(height: 10),
                Text(orStr,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                SizedBox(height: 10),
                Text(signInWithSocialMediaStr,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(isLoginSocial){
                            print(waitStr);
                            Fluttertoast.showToast(
                                msg: waitStr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green.shade200,
                                textColor: Colors.black,
                                fontSize: 14.0);
                            return;
                          }

                          _onPressedExpressLogInButton(context)
                              .whenComplete(() {
                            if (_userId != null && _userId != "") {
                              signup();
                            }
                          });
                        },
                        child:
                            Image.asset(facebookImage, height: 50, width: 50),
                      ),
                      /*SignInButton(
                          padding: 10,
                          buttonSize: ButtonSize.large,
                          buttonType: ButtonType.facebook,
                          onPressed: () {
                            // initiateFacebookLogin();
                            // _updateLoginInfo();
                            // setState(() {
                            // isLoginSocial=false;
                            // });+
                            _onPressedExpressLogInButton(context).whenComplete(() {
                              if (_userId != null || _userId != "") {
                                signup()  .whenComplete(() =>
                                    setState(() {
                                  // isLoginSocial=true;
                                }))
                                    ;
                              }
                            });
                          }),*/
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          if(isLoginSocial){
                            print(waitStr);
                            Fluttertoast.showToast(
                                msg: waitStr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green.shade200,
                                textColor: Colors.black,
                                fontSize: 14.0);
                            return;
                          }
                          setState(() {
                            isLoginSocial = true;
                          });
                          googleSignIn(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Image.asset(googleImage),
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signup() async {
    print("signup");
    final body = {
      "email": _email,
      "image": _imageUrl,
      "userId": _userId,
      "name": _name,
      "provider": _platform
    };
    print("body==$body");
    final response = await post(Uri.parse(socialURL), body: body);
    print("response code == ${response.statusCode}");
    print("response body == ${response.body}");

    if (response.statusCode == 429) {
      Fluttertoast.showToast(
          msg: ToManyRequestStr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade200,
          textColor: Colors.black,
          fontSize: 14.0);
      return;
    }
    if (response.statusCode != 200) {
      Fluttertoast.showToast(
          msg: "Server Issue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade200,
          textColor: Colors.black,
          fontSize: 14.0);
      return;
    }
    final instance = await SharedPreferences.getInstance();
    final parse = jsonDecode(response.body);
    instance.setString(MySharedPref.login, "true");
    instance.setString(MySharedPref.url, parse["data"]);
    instance.setString(MySharedPref.userName, _name!);
    if (parse["status"] == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => dashboard()));
      // print("Api Response fail");
    }
    print("parse=$parse");
  }

  Future emailLogin() async {
    setState(() {
      loginButton = true;
    });
    print("Email signup");
    final body = jsonEncode(
        {"email": _emailController.text, "password": _passwordController.text});
    print("Email Singup body = $body");
    final response = await post(
      Uri.parse(loginURL),
      body: {
        "email": _emailController.text,
        "password": _passwordController.text
      },
    ).whenComplete(() => setState(() {
      loginButton = false;
        }));
    print("user Api Data==${response.statusCode}");
    setState(() {
      loginButton = false;
    });
    if (response.statusCode == 429) {
      Fluttertoast.showToast(
          msg: ToManyRequestStr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade200,
          textColor: Colors.black,
          fontSize: 14.0);
      return;
    }
    if (response.statusCode != 200) {
      return;
    }
    final parse = jsonDecode(response.body);
    print(parse);
    final instance = await SharedPreferences.getInstance();
    instance.setString(MySharedPref.login, "true");
    instance.setString(MySharedPref.url, parse["data"]);
    // instance.setString(MySharedPref.userName, _name!);
    if (parse["status"] == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => dashboard()));
      // print("Api Response fail");
    } else {
      Fluttertoast.showToast(
          msg: parse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade200,
          textColor: Colors.black,
          fontSize: 14.0);
    }
  }

  _forgetLaunchURL() async {
    String url = forgetURL;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
          msg: "Could not launch $url",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade200,
          textColor: Colors.black,
          fontSize: 14.0);
      throw 'Could not launch $url';
    }
  }

  _registrationLaunchURL() async {
    String url = signupURL;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
          msg: "Could not launch $url",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.shade200,
          textColor: Colors.black,
          fontSize: 14.0);
      throw 'Could not launch $url';
    }
  }
}
