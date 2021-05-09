import 'package:flutter/material.dart';

class CenterLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: phoneSize.height * .05),
      child: Container(
        width: phoneSize.width * .4,
        child: Image.asset("assets/images/softinyoLogo.png"),
      ),
    );
  }
}
