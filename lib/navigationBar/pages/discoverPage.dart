import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:softinyo_task/config/colors.dart';
import 'package:softinyo_task/config/homePageItems.dart';

import '../../animation.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FadeAnimation(
        1.2,
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Keşfet"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: homePageItems.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          placeholderFadeInDuration: Duration(microseconds: 0),
                          fadeInDuration: Duration(milliseconds: 0),
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              backgroundColor: MainColors.softinyoPurple,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  MainColors.softinyoGreen),
                            ),
                          ),
                          imageUrl: homePageItems[index]["imgUrl"],
                          fit: BoxFit.cover,
                        ));
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
