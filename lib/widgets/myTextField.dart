import 'package:flutter/material.dart';
import 'package:softinyo_task/config/colors.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  Size phoneSize;
  String hintText;
  TextEditingController controller;
  bool validate;
  bool isPass;
  Function validation;
  MyTextField(
      {this.controller,
      this.hintText,
      this.phoneSize,
      this.validate,
      this.isPass,
      this.validation});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.phoneSize.width * .05,
          vertical: widget.phoneSize.height * .01),
      child: Container(
        decoration: BoxDecoration(
            color: MainColors.backgroundColor2,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: TextFormField(
          validator: widget.validation,
          obscureText: widget.isPass,
          cursorColor: MainColors.softinyoPurple,
          controller: widget.controller,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontStyle: FontStyle.italic,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MainColors.softinyoPurple),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MainColors.softinyoGreen,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MainColors.softinyoPurple,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyTextFieldNoPadding extends StatefulWidget {
  Size phoneSize;
  String hintText;
  TextEditingController controller;
  bool validate;
  bool isPass;
  MyTextFieldNoPadding(
    this.controller,
    this.hintText,
    this.phoneSize,
    this.validate,
    this.isPass,
  );
  @override
  _MyTextFieldNoPaddingState createState() => _MyTextFieldNoPaddingState();
}

class _MyTextFieldNoPaddingState extends State<MyTextFieldNoPadding> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MainColors.backgroundColor2,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: TextField(
          obscureText: widget.isPass,
          cursorColor: MainColors.softinyoPurple,
          controller: widget.controller,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: widget.validate ? "Value can't be empty" : null,
            hintStyle: TextStyle(
              fontStyle: FontStyle.italic,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MainColors.softinyoPurple),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MainColors.softinyoGreen,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
