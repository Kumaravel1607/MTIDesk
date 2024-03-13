import 'package:flutter/material.dart';
import 'package:mtidesk/Constant/color.dart';
import 'package:mtidesk/Dashboard.dart';
import 'package:mtidesk/Leave_Details1.dart';
import 'package:mtidesk/Logout.dart';
import 'package:mtidesk/History.dart';
import 'package:mtidesk/Student_list.dart';
import 'package:mtidesk/message.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarItems(),
      confineInSafeArea: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
          animateTabTransition: true),
      navBarStyle: NavBarStyle.style9,
    );
  }
}

List<PersistentBottomNavBarItem> _navBarItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.home,
        color: Blue,
      ),
      title: ('Home'),
      activeColorPrimary: Colors.blue.shade800,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.list_alt,
        color: Blue,
      ),
      title: ('History'),
      activeColorPrimary: Colors.blue.shade800,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.groups,
        color: Blue,
      ),
      title: ('Students'),
      activeColorPrimary: Colors.blue.shade800,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.logout,
        color: Blue,
      ),
      title: ('Logout'),
      activeColorPrimary: Colors.blue.shade800,
      inactiveColorPrimary: Colors.grey,
    ),
  ];
}

List<Widget> _buildScreens() {
  return [Home(), Request_list(), Student_list(), Logout()];
}

// class Navigation extends StatefulWidget {
//   Navigation({Key? key}) : super(key: key);

//   @override
//   State<Navigation> createState() => _NavigationState();
// }

// class _NavigationState extends State<Navigation> {
//   @override
//   Widget build(BuildContext context) {
//     PersistentTabController controller;
//     controller = PersistentTabController(initialIndex: 0);

//     List<Widget> _buildScreens() {
//       return [Home(), Request_list(), Student_list(), Logout(), Messages()];
//     }

//     List<PersistentBottomNavBarItem> _navBarsItems() {
//       return [
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.home),
//           title: ("Home"),
//           activeColorPrimary: Colors.deepPurple,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.explore),
//           title: ("Explore"),
//           activeColorPrimary: Colors.deepPurple,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.add, color: Colors.white),
//           activeColorPrimary: Colors.deepPurple,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.email),
//           title: ("Inbox"),
//           activeColorPrimary: Colors.deepPurple,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.shopping_bag),
//           title: ("Shop"),
//           activeColorPrimary: Colors.deepPurple,
//           inactiveColorPrimary: Colors.grey,
//         ),
//       ];
//     }

//     return PersistentTabView(
//       context,
//       controller: controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       confineInSafeArea: true,
//       backgroundColor: Colors.white, // Default is Colors.white.
//       handleAndroidBackButtonPress: true, // Default is true.
//       resizeToAvoidBottomInset:
//           true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//       stateManagement: true, // Default is true.
//       hideNavigationBarWhenKeyboardShows:
//           true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//       decoration: NavBarDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         colorBehindNavBar: Colors.white,
//       ),
//       popAllScreensOnTapOfSelectedTab: true,
//       popActionScreens: PopActionScreensType.all,
//       itemAnimationProperties: const ItemAnimationProperties(
//         // Navigation Bar's items animation properties.
//         duration: Duration(milliseconds: 200),
//         curve: Curves.ease,
//       ),
//       screenTransitionAnimation: const ScreenTransitionAnimation(
//         // Screen transition animation on change of selected tab.
//         animateTabTransition: true,
//         curve: Curves.ease,
//         duration: Duration(milliseconds: 200),
//       ),
//       navBarStyle:
//           NavBarStyle.style15, // Choose the nav bar style with this property.
//     );
//   }
// }
