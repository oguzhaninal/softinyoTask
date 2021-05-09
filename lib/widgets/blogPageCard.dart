import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:softinyo_task/config/colors.dart';
import 'package:softinyo_task/config/homePageItems.dart';

class BlogPageCard extends StatefulWidget {
  Map item;
  BlogPageCard(this.item);

  @override
  _BlogPageCardState createState() => _BlogPageCardState();
}

class _BlogPageCardState extends State<BlogPageCard> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 15, right: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey[300],
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
      ]),
      height: phoneSize.height * .4,
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: phoneSize.width,
              height: phoneSize.height * .32,
              child: CachedNetworkImage(
                placeholderFadeInDuration: Duration(microseconds: 0),
                fadeInDuration: Duration(milliseconds: 0),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    backgroundColor: MainColors.softinyoPurple,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(MainColors.softinyoGreen),
                  ),
                ),
                imageUrl: widget.item["imgUrl"],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: phoneSize.width * .05,
                  right: phoneSize.width * .02,
                  top: phoneSize.height * .01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        text: widget.item["id"] + "  ",
                        children: [
                          TextSpan(
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            text: widget.item["title"],
                          )
                        ]),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(FlutterIcons.like_sli,
                            color: isLike ? Colors.red : Colors.black),
                        onPressed: () {
                          setState(() {
                            isLike = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          FlutterIcons.dislike_sli,
                          color: !isLike ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            isLike = false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
