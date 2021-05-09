import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softinyo_task/animation.dart';
import 'package:softinyo_task/config/values.dart';
import 'package:softinyo_task/models/userModel.dart';
import 'package:softinyo_task/screens/setInfoScreen.dart';
import 'package:softinyo_task/widgets/centerLogo.dart';
import 'package:softinyo_task/widgets/myButton.dart';
import 'package:softinyo_task/widgets/myTextField.dart';
import 'package:http/http.dart' as http;
import 'package:softinyo_task/navigationBar/navigationBar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController eMailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool valueEMail = false;
  bool valuePass = false;

  // ignore: missing_return
  Future<Map> login(
    String eMail,
    String pass,
  ) async {
    final body = jsonEncode({
      "roll": "login",
      "email": eMail,
      "passphrase": pass,
    });
    var jsonData;

    var response = await http.post(apiUrl, body: {"data": body});
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      showInSnackBar("Daha sonra tekrar deneyiniz!");
    }
  }

  isLoginTrue(jsonData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", true);
    prefs.setString("userInfo", jsonData["response"].toString());
    prefs.setString("loginAuthKey", jsonData["response"]["loginAuthKey"]);
    UserModel.instance.updateData(jsonData["response"]);
    if (prefs.getBool("isFirstLogin") == false || null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SetInfoPage(
            isSetting: false,
            text1: "Hoş Geldiniz..",
            text2: " Devam etmek için lütfen hobi ve yetenek seçiniz",
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => NavigationBar(0)),
      );
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

  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return SafeArea(
      child: FadeAnimation(
        1.2,
        Scaffold(
          key: scaffoldKey,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CenterLogo(),
                Padding(
                  padding: EdgeInsets.only(left: phoneSize.width * .05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hoş Geldiniz"),
                        RichText(
                          text: TextSpan(
                            text: "Devam etmek için lütfen,",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " giriş yapınız..",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MyTextField(
                    controller: eMailController,
                    hintText: "Epostanız",
                    phoneSize: phoneSize,
                    validate: valueEMail,
                    isPass: false),
                MyTextField(
                    controller: passController,
                    hintText: "Şifreniz",
                    phoneSize: phoneSize,
                    validate: valuePass,
                    isPass: true),
                MyButton(() {
                  login(eMailController.text, passController.text)
                      .then((value) {
                    if (value["basarim"] == 1) {
                      isLoginTrue(value);
                    } else if (value["basarim"] == 0) {
                      showInSnackBar("Kullanıcı adı ya da şifre hatalı");
                    }
                  });
                }, phoneSize, "Giriş Yap"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
