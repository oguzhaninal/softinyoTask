import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:softinyo_task/config/colors.dart';

// ignore: must_be_immutable
class MyCard extends StatelessWidget {
  Map item;

  Size phoneSize;
  MyCard(this.item, this.phoneSize);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey[300],
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
      ]),
      height: phoneSize.height * .18,
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: phoneSize.height * .18,
              height: phoneSize.height * .18,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
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
                    imageUrl: item["imgUrl"],
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: phoneSize.width * .02, top: phoneSize.height * .01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: phoneSize.width * .5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item["title"]),
                        Text(item["id"]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        // left: phoneSize.width * .025,

                        right: phoneSize.width * .01,
                        top: phoneSize.height * .01),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: MainColors.softinyoPurple,
                          ),
                        ),
                      ),
                      width: phoneSize.width * .5,
                      height: phoneSize.height * .122,
                      child: Padding(
                        padding: EdgeInsets.only(top: phoneSize.height * .005),
                        child: Text(
                          item["description"],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          // softWrap: true,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
