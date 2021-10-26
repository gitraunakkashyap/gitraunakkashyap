import 'package:flutter/material.dart';
import 'package:store/screens/account_detail.dart';
import 'package:store/screens/homebody.dart';

class Home extends StatelessWidget{

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
  new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.menu),
      //     tooltip: 'Open Navigation Drawer',
      //     onPressed: () {
      //       if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
      //         Navigator.pop(context);
      //       } else {
      //         _drawerscaffoldkey.currentState!.openDrawer();
      //       }
      //     },
      //   ),
      //   backgroundColor: Colors.green[900],
      //   title: Text(
      //     "HOME",
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.notifications),
      //       tooltip: 'Open Navigation Drawer',
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.shopping_cart),
      //       tooltip: 'Open Navigation Drawer',
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: homebody(),
          //Main data here
        ),
      )
    );
  }

}
