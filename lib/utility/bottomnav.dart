import 'package:flutter/material.dart';
import 'package:store/screens/account_detail.dart';
import 'package:store/screens/categoryPage.dart';
import 'package:store/screens/categoryRoute.dart';
import 'package:store/screens/homeDashboard.dart';
import 'package:store/screens/homePage.dart';
import 'package:store/screens/homebody.dart';
import 'package:store/screens/search_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // Widget _widgetOptions =
  // switch (_selectedIndex) {
  // case 0:
  // _widgetOptions = FlutterLogo();
  // break;
  // case 1:
  // _widgetOptions = FlutterLogo(colors: Colors.orange);
  // break;
  // case 2:
  // _widgetOptions = FlutterLogo(colors: Colors.red);
  // break;
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: _widgetOptions.elementAt(_selectedIndex),
  //     ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       items: <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.home),
  //             label: 'HOME',
  //             backgroundColor: Colors.green[900]),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.category),
  //             label: 'CATEGORY',
  //             backgroundColor: Colors.green[900]),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.search),
  //             label: 'SEARCH',
  //             backgroundColor: Colors.green[900]),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.account_circle_outlined),
  //             label: 'ACCOUNT',
  //             backgroundColor: Colors.green[900]),
  //       ],
  //       currentIndex: _selectedIndex = 0,
  //       selectedItemColor: Colors.amber[800],
  //       onTap: _onItemTapped,
  //     ),
  //   );
  // }

  ///////////////////////////////////////////////////////////////////////////////////////
  // int _index = 0;
//
// @override
// Widget build(BuildContext context) {
//   Widget child;
//   switch (_index) {
//     case 0:
//       child = FlutterLogo();
//       break;
//     case 1:
//       child = FlutterLogo(color: Colors.orange);
//       break;
//     case 2:
//       child = FlutterLogo(color: Colors.red);
//       break;
//   }

  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [
    Home(),
    CategoryRoute(),
    SearchPage(),
    account_detail(),
  ];


  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.green[900],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home,), title: Text("Home",)),
          BottomNavigationBarItem(icon: Icon(Icons.category,), title: Text("Category",)),
          BottomNavigationBarItem(icon: Icon(Icons.search,), title: Text("Search",)),
          BottomNavigationBarItem(icon: Icon(Icons.person,), title: Text("Account",)),
        ],

      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(child: Text("Screen 1")),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(child: Text("Screen 2")),
    );
  }
}

// class Screen3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//   return Container(
//   color: Colors.cyan,
//   child: Center(child: Text("Screen 3")),
//   );
//   }
//   }

  // var _currentTab = TabItem.red;
  // final _navigatorKeys = {
  //   TabItem.red: GlobalKey<NavigatorState>(),
  //   TabItem.green: GlobalKey<NavigatorState>(),
  //   TabItem.blue: GlobalKey<NavigatorState>(),
  // };
  //
  // void _selectTab(TabItem tabItem) {
  //   if (tabItem == _currentTab) {
  //     // pop to first route
  //     _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
  //   } else {
  //     setState(() => _currentTab = tabItem);
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //     onWillPop: () async {
  //       final isFirstRouteInCurrentTab =
  //       !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
  //       if (isFirstRouteInCurrentTab) {
  //         // if not on the 'main' tab
  //         if (_currentTab != TabItem.red) {
  //           // select 'main' tab
  //           _selectTab(TabItem.red);
  //           // back button handled by app
  //           return false;
  //         }
  //       }
  //       // let system handle back button if we're on the first route
  //       return isFirstRouteInCurrentTab;
  //     },
  //     child: Scaffold(
  //       body: Stack(children: <Widget>[
  //         _buildOffstageNavigator(TabItem.red),
  //         _buildOffstageNavigator(TabItem.green),
  //         _buildOffstageNavigator(TabItem.blue),
  //       ]),
  //       bottomNavigationBar: BottomNavigation(
  //         currentTab: _currentTab,
  //         onSelectTab: _selectTab,
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildOffstageNavigator(TabItem tabItem) {
  //   return Offstage(
  //     offstage: _currentTab != tabItem,
  //     child: TabNavigator(
  //       navigatorKey: _navigatorKeys[tabItem],
  //       tabItem: tabItem,
  //     ),
  //   );
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
  //
