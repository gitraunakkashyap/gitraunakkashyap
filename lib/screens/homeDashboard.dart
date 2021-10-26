import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:store/screens/homebody.dart';
import 'package:store/utility/bottomnav.dart';
import 'package:store/widgets/button.dart';
import 'package:store/screens/account_detail.dart';

class dashboard extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Open Navigation Drawer',
          onPressed: () {
            if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
              Navigator.pop(context);
            } else {
              _drawerscaffoldkey.currentState!.openDrawer();
            }
          },
        ),
        backgroundColor: Colors.green[900],
        title: Text(
          "BEDESI STORE",
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Open Navigation Drawer',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Open Navigation Drawer',
            onPressed: () {},
          ),
        ],
      ),
      key: _drawerscaffoldkey,
      drawer: Container(
        width: 270,
        child: Drawer(
          child: SingleChildScrollView(
            //Drawer content here
            //we can design our own drawer menu here
            child: Container(
              color: Colors.green[900],
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: ListView(
                padding: EdgeInsets.only(left: 12.0, top: 12.0),
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 12),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: ExactAssetImage(
                                      'assets/images/slider2.jpg'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Raunak Kashyap",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.left),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "raunakkashyap3@gmail.com",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.left,
                                    )),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          //   width: 10,
                          // ),
                          // Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Container(
                          //         child: IconButton(
                          //       icon: new Icon(
                          //         Icons.settings,
                          //         color: Colors.white,
                          //         size: 26,
                          //       ),
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => account_detail()),
                          //         );
                          //       },
                          //     )
                          //     )
                          // ),
                        ],
                      )), // Account
                  Row(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 2.0,
                        width: 244.0,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.zero,
                  //       // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //       height: 40,  //gives the height of the dropdown button
                  //       width: 233, //gives the width of the dropdown button
                  //       decoration: BoxDecoration(
                  //           border: Border.all(color: Colors.white),
                  //           borderRadius: BorderRadius.all(Radius.circular(3),)
                  //       ),
                  //       child: Theme(
                  //         data: Theme.of(context).copyWith(
                  //             canvasColor: Colors.green[900], // background color for the dropdown items
                  //             // buttonTheme: ButtonTheme.of(context).copyWith(
                  //             //   // alignedDropdown: true,  //If false (the default), then the dropdown's menu will be wider than its button.
                  //             // )
                  //         ),
                  //         child: DropdownButtonHideUnderline(
                  //             child: ButtonTheme(
                  //               padding: EdgeInsets.zero,
                  //               alignedDropdown: true,
                  //               child: MyStatefulWidget(),)
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 12.0,)
                  //   ],
                  // ), //Category

                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Track Order",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left),
                          ),
                          SizedBox(
                            height: 10,
                            width: 105,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.track_changes,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ],
                      )), //Track order
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("History",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left),
                          ),
                          SizedBox(
                            height: 10,
                            width: 137.5,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.history,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ],
                      )), //History
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Contact Us",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left),
                          ),
                          SizedBox(
                            height: 10,
                            width: 105,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.contact_mail_outlined,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 40,
                  ), //Contact Us
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Rate Us",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left),
                          ),
                          // SizedBox(
                          //   height: 10,
                          //   width: 110,
                          // ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Icon(
                          //     Icons.account_circle,
                          //     color: Colors.white,
                          //     size: 26,
                          //   ),
                          // ),
                        ],
                      )), //Rate Us
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Privacy Policy",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left),
                          ),
                          // SizedBox(
                          //   height: 10,
                          //   width: 110,
                          // ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Icon(
                          //     Icons.account_circle,
                          //     color: Colors.white,
                          //     size: 26,
                          //   ),
                          // ),
                        ],
                      )), //Privacy Policy
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Terms & Conditions",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left),
                          ),
                          // SizedBox(
                          //   height: 10,
                          //   width: 110,
                          // ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Icon(
                          //     Icons.account_circle,
                          //     color: Colors.white,
                          //     size: 26,
                          //   ),
                          // ),
                        ],
                      )),
                  SizedBox(
                    height: 90,
                  ), //Terms and Conditions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "LOGOUT",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                                width: 20,
                              ),
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 26,
                              )
                            ],
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.only(left: 30, right: 25),
                          side: BorderSide(width: 1.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ), //Logout
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: TextButton(
                        onPressed: () {},
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text("FOLLOW US",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text("ON SOCIAL MEDIA",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround, //Center Column contents vertically,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, //Center Column contents horizontally,
                                children: <Widget>[
                                  Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  Icon(
                                    Icons.facebook,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Scaffold(
        bottomNavigationBar: BottomNavBar(),
      ),
    );
    // Center(child: _buildMarquee(),
  }
}


/// This is the private State class that goes with MyStatefulWidget.
/// And is created here for having a drop down list for category in navigation drawer.

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'Cooking Oil & Ghee';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.white,),
      iconSize: 24,
      style: const TextStyle(color: Colors.white, fontSize: 20.0),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Cooking Oil & Ghee', 'Food Grains', 'Honey', 'Pickles', 'Spices', 'Hand Craft']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
