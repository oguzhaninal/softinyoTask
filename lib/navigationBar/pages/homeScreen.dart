import 'package:flutter/material.dart';
import 'package:softinyo_task/animation.dart';
import 'package:softinyo_task/config/colors.dart';
import 'package:softinyo_task/config/homePageItems.dart';
import 'package:softinyo_task/navigationBar/navigationBar.dart';
import 'package:softinyo_task/widgets/myCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return SafeArea(
      child: FadeAnimation(
        1.2,
        Scaffold(
          appBar: AppBar(
            title: Text("Ana Sayfa"),
            automaticallyImplyLeading: false,
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    color: MainColors.softinyoPurple,
                    onRefresh: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (a, b, c) => NavigationBar(0),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                      return;
                    },
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        itemCount: homePageItems.length,
                        itemBuilder: (BuildContext context, index) {
                          return MyCard(homePageItems[index], phoneSize);
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
