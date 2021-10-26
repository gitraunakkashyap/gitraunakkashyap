/*import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/screens/webScreen.dart';
import '/utility/share_pref.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController _otpController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String verId = "";

  // bool loading = false;

// String phone="";
  bool isLoading = false;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.green.shade100,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Image.asset(
                    "assets/login_transparent.png",
                    width: 150,
                    height: 150,
                  )),
                ),
                codeSent
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextField(
                              controller: _otpController,
                              textAlign: TextAlign.center,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                hintText: 'Enter OTP',
                              ),
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                // FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6)
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          isLoading
                              ? Center(child: CircularProgressIndicator())
                              : GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    if (_otpController.text.length < 6) {
                                      Fluttertoast.showToast(
                                          msg: "Enter OTP",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green.shade200,
                                          textColor: Colors.black,
                                          fontSize: 14.0);
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });
                                    verifyPin(_otpController.text)
                                        .whenComplete(() {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  },
                                  child: Container(
                                    child: Text(
                                      "Verify OTP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 20),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 40),
                                  ),
                                ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "+91",
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _phoneController,
                                    decoration: new InputDecoration(
                                        // prefixText: "+91",
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0),
                                        ),
                                        hintText: 'Enter Mobile Number',
                                        hintStyle: TextStyle(fontSize: 24)),
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(fontSize: 24),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            isLoading
                                ? Center(child: CircularProgressIndicator())
                                : GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      if(_phoneController.text.length<10){
                                        Fluttertoast.showToast(
                                            msg: "Enter Mobile Number",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green.shade200,
                                            textColor: Colors.black,
                                            fontSize: 14.0);
                                        return;
                                      }
                                      setState(() {
                                        isLoading = true;
                                      });
                                      verifyPhone();
                                    },
                                    child: Container(
                                      child: Text(
                                        "Send OTP",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 20),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 40),
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

  Future<void> verifyPhone() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${_phoneController.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await FirebaseAuth.instance.signInWithCredential(credential);
          // final snackBar = SnackBar(content: Text("Login Success"));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // phoneLogin();
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            isLoading = false;
          });
          final snackBar = SnackBar(content: Text("${e.message}"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verficationId, int? resendToken) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "OTP Send",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green.shade200,
              textColor: Colors.black,
              fontSize: 14.0);
          setState(() {
            codeSent = true;
            verId = verficationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            verId = verificationId;
          });
        },
        timeout: Duration(seconds: 60));
  }

  Future<void> verifyPin(String pin) async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);

    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) => print(value.user));
      const snackBar = SnackBar(content: Text("Login Success"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      phoneLogin();
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(content: Text("${e.message}"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future phoneLogin() async {
    setState(() {
      isLoading = true;
    });
    print("mobile login");
    final body = {
      "mobile": "+91${_phoneController.text}",
    };
    print("mobile login body = $body");
    final response = await post(
        Uri.parse("https://www.bedesistore.com/api/user/login-with-otp"),
        body: body);
    setState(() {
      isLoading = false;
    });
    print("user Api statusCode==${response.statusCode}");
    if (response.statusCode == 429) {
      final parse = jsonDecode(response.body);
      Fluttertoast.showToast(
          msg: parse["message"],
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

    // instance.setString(MySharedPref.userName, _name!);
    if (parse["status"] == "success") {
      instance.setString(MySharedPref.login, "true");
      instance.setString(MySharedPref.url, parse["data"]);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WebScreen()));
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
}

/*

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController _phoneController = TextEditingController(text: "+919509998880");
  final firebase = FirebaseAuth.instance;
  bool isLoading = false;
  String? verificationId;
  Future phoneAuth() async {
    // if()
    firebase.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {},
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());

      },
      child: Scaffold(
        backgroundColor: Colors.green.shade100,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: true
                      ? Image.asset(
                          "assets/login_transparent.png",
                          width: 150,
                          height: 150,
                        )
                      : CircularProgressIndicator(),
                ),
              ),
              Text(
                "LOGIN USING OTP",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 70),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("+91",style: TextStyle(fontSize: 24)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      decoration: new InputDecoration(
                        // prefixText: "+91",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        hintText: '**********',
                        hintStyle: TextStyle(fontSize: 24)
                      ),
                      keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 24),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GestureDetector(
                  onTap: () {
                    phoneSignIn(phoneNumber: _phoneController.text);},
                  child: Container(
                    child: Text(
                      "Get OTP",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> phoneSignIn({required String phoneNumber}) async {
    // await firebase.signInWithPhoneNumber("");
    print("phoneSignIn call $phoneNumber");
    await firebase.verifyPhoneNumber(
        phoneNumber: "+919509998880",
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);

  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("_onVerificationCompleted call");

    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      this._phoneController.text = authCredential.smsCode!;
    });
    if (authCredential.smsCode != null) {
      try{
        UserCredential credential =
        await user!.linkWithCredential(authCredential);
      }on FirebaseAuthException catch(e){
        if(e.code == 'provider-already-linked'){
          await firebase.signInWithCredential(authCredential);
        }
      }
      setState(() {
        isLoading = false;
      });
      // Navigator.pushNamedAndRemoveUntil(context, Constants.homeNavigate, (route) => false);
    }
  }
  _onVerificationFailed(FirebaseAuthException exception) {
    print("_onVerificationFailed call");

    if (exception.code == 'invalid-phone-number') {
      showMessage("The phone number entered is invalid!");
    }
  }
  _onCodeSent(String verificationId, int? forceResendingToken) async {
    print("_onCodeSent call");
    FirebaseAuth auth = FirebaseAuth.instance;

// Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber('+919509998880');
    this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
    // Navigator.push(context, MaterialPageRoute(builder: OTPScreen()));
    // ek min client call
  }
  _onCodeTimeout(String timeout) {
    print("_onCodeTimeout call");
    return null;
  }
  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        // isLoading = false;
      });
    });
  }
}
*/
*/



/*
TextEditingController _otpController = TextEditingController(text: "123456");
TextEditingController _phoneController = TextEditingController(text: "+919509998880");
String verId="";
// String phone="";
bool codeSent = false;

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          codeSent
              ?
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _otpController,textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    hintText: '******',
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    // FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6)
                  ],
                ),
              ),
              const SizedBox(
                  height: 10
              ),
              ElevatedButton(
                  onPressed: () {
                    verifyPin(_otpController.text);
                  },
                  child: const Text("Verify"))
            ],
          )
              :              Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _phoneController,
                  decoration: new InputDecoration(
                    // prefixText: "+91",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      hintText: '**********',
                      hintStyle: TextStyle(fontSize: 24)
                  ),
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontSize: 24),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                ),
              ),
              const SizedBox(
                  height: 10
              ),
              ElevatedButton(
                  onPressed: () {
                    verifyPhone();
                  },
                  child: const Text("Verify"))
            ],
          ),
        ],
      ),
    ),
  );
}

Future<void> verifyPhone() async {
  await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        final snackBar = SnackBar(content: Text("Login Success"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      verificationFailed: (FirebaseAuthException e) {
        final snackBar = SnackBar(content: Text("${e.message}"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      codeSent: (String verficationId, int? resendToken) {
        setState(() {
          codeSent = true;
          verId = verficationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          verId = verificationId;
        });
      },
      timeout: Duration(seconds: 60));
}

Future<void> verifyPin(String pin) async {
  PhoneAuthCredential credential =
  PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);

  try {
    await FirebaseAuth.instance.signInWithCredential(credential);
    const snackBar = SnackBar(content: Text("Login Success"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } on FirebaseAuthException catch (e) {
    final snackBar = SnackBar(content: Text("${e.message}"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}*/

