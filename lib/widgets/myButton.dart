import 'package:flutter/material.dart';
import 'package:softinyo_task/config/colors.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  Function func;
  Size phoneSize;
  String buttonName;
  MyButton(this.func, this.phoneSize, this.buttonName);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Padding(
        padding: EdgeInsets.only(
            right: phoneSize.width * .05,
            top: phoneSize.height * .02,
            bottom: phoneSize.height * .02),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: phoneSize.height * .08,
            width: phoneSize.width * .35,
            decoration: BoxDecoration(
              color: MainColors.softinyoPurple,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
