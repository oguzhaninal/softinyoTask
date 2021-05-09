import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:softinyo_task/config/colors.dart';
import 'package:softinyo_task/navigationBar/pages/blogPage.dart';
import 'package:softinyo_task/navigationBar/pages/discoverPage.dart';
import 'package:softinyo_task/navigationBar/pages/homeScreen.dart';
import 'package:softinyo_task/navigationBar/pages/informationPage.dart';
import 'package:softinyo_task/navigationBar/pages/profilePage.dart';

class NavigationBar extends StatefulWidget {
  final int indexN;

  NavigationBar(this.indexN);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int selectedPage = 0;
  final screens = [
    HomePage(),
    DiscoverPage(),
    BlogPage(),
    InfoPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedPage],
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        snakeViewColor: MainColors.softinyoGreen,
        unselectedItemColor: MainColors.softinyoPurple,
        selectedItemColor: MainColors.softinyoPurple,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        currentIndex: selectedPage,
        onTap: (indexN) => setState(() => selectedPage = indexN),
        items: [
          BottomNavigationBarItem(
              icon: Icon(FlutterIcons.home_oct), label: "Ana Sayfa"),
          BottomNavigationBarItem(
              icon: Icon(FlutterIcons.search1_ant), label: "Keşfet"),
          BottomNavigationBarItem(
              icon: Icon(FlutterIcons.list_fea), label: "Blog"),
          BottomNavigationBarItem(
              icon: Icon(FlutterIcons.information_mco), label: "Bilgi"),
          BottomNavigationBarItem(
              icon: Icon(FlutterIcons.person_outline_mdi), label: "Profil")
        ],
      ),
    );
  }
}
