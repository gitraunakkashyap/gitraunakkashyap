import 'package:flutter/material.dart';

class account_detail extends StatefulWidget {
  // account_detail({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<account_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            profileView() // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget profileView() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'PROFILE DETAIL',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              // Container(height: 24, width: 24)
            ],
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/slider1.jpg',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Positioned(
              //     bottom: 1,
              //     right: 1,
              //     child: Container(
              //       height: 40,
              //       width: 40,
              //       child: Icon(
              //         Icons.add_a_photo,
              //         color: Colors.white,
              //       ),
              //       decoration: BoxDecoration(
              //           color: Colors.deepOrange,
              //           borderRadius: BorderRadius.all(Radius.circular(20))),
              //     ))
            ],
          ),
        ),
        Expanded(
            child: Column(
            children: [Padding(padding: EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.green
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Name',
                              style:
                              TextStyle(color: Colors.white70, fontSize: 18),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                            Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Email',
                              style:
                              TextStyle(color: Colors.white70, fontSize: 18),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                            Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Phone No.',
                              style:
                              TextStyle(color: Colors.white70, fontSize: 18),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                            Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                      child: Container(
                        height: 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Address',
                              style:
                              TextStyle(color: Colors.white70, fontSize: 18),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                            Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                  ],
                ),
              ),
            )

          ],
        )),
        // SizedBox(
        //   height: 12,
        // ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: 200,
              child: Align(
                child: Text(
                  'View Full Profile',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.green[900],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
