import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:softinyo_task/animation.dart';
import 'package:softinyo_task/config/colors.dart';
import 'package:softinyo_task/config/hobbyList.dart';
import 'package:softinyo_task/config/values.dart';
import 'package:softinyo_task/models/userModel.dart';
import 'package:softinyo_task/navigationBar/navigationBar.dart';
import 'package:softinyo_task/widgets/centerLogo.dart';
import 'package:softinyo_task/widgets/myButton.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

// ignore: must_be_immutable
class SetInfoPage extends StatefulWidget {
  bool isSetting;
  String text1;
  String text2;
  SetInfoPage({this.isSetting, this.text1, this.text2});
  @override
  _SetInfoPageState createState() => _SetInfoPageState();
}

class _SetInfoPageState extends State<SetInfoPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  SharedPreferences prefs;
  String hobby;
  String skill;
  bool isNotificationOpen;

  setInfo(String hobby, String skill) async {
    final body = jsonEncode({
      "roll": "insertInfo",
      "loginAuthKey": UserModel.instance.loginAuthkey,
      "information": UserModel.instance.fName,
      "hobby": hobby,
      "skill": skill,
    });
    var jsonData;
    var response = await http.post(apiUrl, body: {"data": body});

    if (response.statusCode == 200) {
      prefs.setBool("isFirstLogin", true);
      print(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => NavigationBar(0)));
    } else {
      showInSnackBar("Daha sonra tekrar deneyiniz");
    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(value),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "Tamam",
          onPressed: () {
            scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  setPushOff(isTrue) async {
    setState(() {
      isNotificationOpen = !isNotificationOpen;
    });
    OneSignal.shared.setSubscription(isTrue);
    prefs.setBool("isPermissionGiven", isTrue);
  }

  getPermission() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      isNotificationOpen = prefs.getBool("isPermissionGiven") ?? true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return SafeArea(
      child: FadeAnimation(
        1.2,
        Scaffold(
          key: scaffoldKey,
          appBar: widget.isSetting
              ? AppBar(
                  title: Text("Ayarlar"),
                )
              : null,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CenterLogo(),
                alignText(phoneSize, widget.text1),
                alignText(phoneSize, widget.text2),
                hobyList(phoneSize),
                skillList(phoneSize),
                if (widget.isSetting == true) notifSwitch(phoneSize),
                MyButton(() {
                  setInfo(hobby, skill);
                }, phoneSize, "Onayla")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding notifSwitch(Size phoneSize) {
    return Padding(
      padding: EdgeInsets.only(
          left: phoneSize.width * .05,
          right: phoneSize.width * .05,
          bottom: phoneSize.height * .01),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(8, 8),
              blurRadius: 8,
              spreadRadius: -8,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SwitchListTile(
                // subtitle: Text("data"),
                activeColor: MainColors.mainOrange,
                inactiveThumbColor: MainColors.mainOrange,
                inactiveTrackColor: Colors.grey[200],
                contentPadding: EdgeInsets.all(0),
                title: Text("Bildirim almak istiyor musunuz"),
                value: isNotificationOpen,
                onChanged: (bool value) {
                  setPushOff(value);
                }),
          ),
        ),
      ),
    );
  }

  alignText(Size phoneSize, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: phoneSize.width * .05, vertical: phoneSize.height * .01),
      child: Align(alignment: Alignment.centerLeft, child: Text(text)),
    );
  }

  skillList(Size phoneSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: phoneSize.width * .05, vertical: phoneSize.height * .02),
      child: Container(
        width: phoneSize.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(8, 8),
              blurRadius: 4,
              spreadRadius: -8,
            )
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SearchableDropdown.single(
              items: hobbies,
              clearIcon: Icon(FlutterIcons.clear_mdi,
                  color: MainColors.softinyoPurple),
              isExpanded: true,
              hint: Text("Yetenek Seç"),
              searchHint: Text("Bir yetenek arayın.."),
              closeButton: "Kapat",
              value: skill,
              underline: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: phoneSize.width * .025),
                child: Container(
                    height: phoneSize.height * .002,
                    color: MainColors.softinyoGreen),
              ),
              onChanged: (String newValue) {
                setState(() {
                  skill = newValue;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  hobyList(Size phoneSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: phoneSize.width * .05),
      child: Container(
        width: phoneSize.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(8, 8),
              blurRadius: 4,
              spreadRadius: -8,
            )
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SearchableDropdown.single(
              items: hobbies,
              clearIcon: Icon(FlutterIcons.clear_mdi,
                  color: MainColors.softinyoPurple),
              isExpanded: true,
              hint: Text("Hobi Seç"),
              searchHint: Text("Bir hobi arayın.."),
              closeButton: "Kapat",
              value: hobby,
              underline: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: phoneSize.width * .025),
                child: Container(
                  height: phoneSize.height * .002,
                  color: MainColors.softinyoGreen,
                ),
              ),
              onChanged: (String newValue) {
                setState(() {
                  hobby = newValue;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
