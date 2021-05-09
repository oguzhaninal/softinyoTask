import 'package:flutter/material.dart';
import 'package:softinyo_task/animation.dart';
import 'package:softinyo_task/config/homePageItems.dart';
import 'package:softinyo_task/widgets/blogPageCard.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FadeAnimation(
        1.2,
        Scaffold(
          appBar: AppBar(
            title: Text("Blog"),
            automaticallyImplyLeading: false,
          ),
          body: Container(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: homePageItems.length,
                itemBuilder: (BuildContext context, index) {
                  return BlogPageCard(homePageItems[index]);
                }),
          ),
        ),
      ),
    );
  }
}
