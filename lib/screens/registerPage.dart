import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:softinyo_task/animation.dart';
import 'package:softinyo_task/config/colors.dart';
import 'package:softinyo_task/config/values.dart';
import 'package:softinyo_task/screens/loginPage.dart';
import 'package:softinyo_task/widgets/centerLogo.dart';
import 'package:softinyo_task/widgets/myButton.dart';
import 'package:softinyo_task/widgets/myTextField.dart';
import 'package:flutter/cupertino.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController fNameController = TextEditingController();
  TextEditingController sNameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool valuefName = false;
  bool valuesName = false;
  bool valueseMail = false;
  bool valuesPass = false;
  bool valueCode = false;
  bool isFemale = true;
  bool isDateEmpty = false;
  DateTime selectedDate;

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

  selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2022),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        isDateEmpty = false;
      });
    print(
        "${selectedDate.year} / ${selectedDate.month} / ${selectedDate.day} ");
  }

  // ignore: missing_return
  Future<Map> register(String fName, String sName, String eMail, String pass,
      String dateTime, int gender, Size phoneSize) async {
    final body = jsonEncode({
      "roll": "register",
      "fName": fName,
      "sName": sName,
      "email": eMail,
      "passphrase": pass,
      "burnDate": dateTime.toString(),
      "gender": gender,
    });
    var response = await http.post(apiUrl, body: {"data": body});
    print("koddd" + response.statusCode.toString());
    if (response.statusCode == 200) {
      var encodeFirst = jsonEncode(response.body.toString());
      var jsonData = jsonDecode(encodeFirst);
      return jsonData;
    }
    if (response.statusCode == 302) {
      showInSnackBar("Farkl?? bir eposta giriniz");
    }
  }

  verify(String verifyCode, Size phoneSize) async {
    final verifyBody = jsonEncode({
      "roll": "checkedMail",
      "verifyCode": verifyCode,
    });
    var responseVerify = await http.post(apiUrl, body: {"data": verifyBody});

    if (responseVerify.statusCode == 200) {
      var encodeFirst = jsonEncode(responseVerify.body.toString());
      var jsonData = jsonDecode(encodeFirst);
      print("d??n??????" + jsonData);
    }
  }

  showBottomSheet(Size phoneSize) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          20,
        ),
      )),
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: phoneSize.width * .05,
                  top: phoneSize.height * .02,
                  bottom: phoneSize.height * .02),
              child: Text("Do??rulama Kodunuzu Girinz"),
            ),
            MyTextField(
                controller: codeController,
                hintText: "Do??rulama Kodunuz",
                phoneSize: phoneSize,
                validate: valueCode,
                isPass: false),
            SizedBox(
              height: 15,
            ),
            MyButton(() {
              verify(codeController.text, phoneSize);
            }, phoneSize, "Onayla")
          ],
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
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
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
                            Text("Ho?? Geldiniz"),
                            RichText(
                                text: TextSpan(
                                    text: "Devam etmek i??in l??tfen,",
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                  TextSpan(
                                      text: " kay??t olunuz..",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ])),
                          ],
                        ),
                      ),
                    ),
                    MyTextField(
                      controller: fNameController,
                      hintText: "Ad??n??z",
                      phoneSize: phoneSize,
                      validate: valuefName,
                      isPass: false,
                      validation: (String value) {
                        if (value == null || value.length == 0) {
                          return "Bo?? olamaz";
                        }
                      },
                    ),
                    MyTextField(
                      controller: sNameController,
                      hintText: "Soyad??n??z",
                      phoneSize: phoneSize,
                      validate: valuesName,
                      isPass: false,
                      validation: (String value) {
                        if (value == null || value.length == 0) {
                          return "Bo?? olamaz";
                        }
                      },
                    ),
                    MyTextField(
                      controller: eMailController,
                      hintText: "e-Postan??z",
                      phoneSize: phoneSize,
                      validate: valueseMail,
                      isPass: false,
                      validation: (String value) {
                        if (value == null || value.length == 0) {
                          return "Bo?? olamaz";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Ge??ersiz Format";
                        }
                      },
                    ),
                    MyTextField(
                      controller: passController,
                      hintText: "??ifreniz",
                      phoneSize: phoneSize,
                      validate: valuesPass,
                      isPass: true,
                      validation: (String value) {
                        if (value == null || value.length == 0) {
                          return "Bo?? olamaz";
                        } else if (value.length < 6) {
                          return "??ifre 6 karakterden k??????k olamaz";
                        }
                      },
                    ),
                    timePicker(phoneSize),
                    selectGender(phoneSize),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: phoneSize.width * .05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showBottomSheet(phoneSize);
                            },
                            child: Text(
                              "Do??rulama kodun mu var?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage()),
                                  (route) => false);
                            },
                            child: Text(
                              "Hesab??n m?? var? Giri?? Yap",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyButton(() {
                      if (selectedDate == null) {
                        setState(() {
                          isDateEmpty = true;
                        });
                      }
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        register(
                          fNameController.text,
                          sNameController.text,
                          eMailController.text,
                          passController.text,
                          "${selectedDate.year}/${selectedDate.day}/${selectedDate.month}",
                          isFemale ? 1 : 0,
                          phoneSize,
                        ).then((value) {
                          if (value["basarim"] == 1) {
                            showBottomSheet(phoneSize);
                          } else if (value["basarim"] == 0) {
                            showInSnackBar(value["message"]);
                          }
                        });
                      }
                    }, phoneSize, "Kay??t Ol"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  selectGender(Size phoneSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: phoneSize.width * .05, vertical: phoneSize.height * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Cinsiyet Se??iniz:"),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: phoneSize.width * .015),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFemale = true;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color:
                            isFemale ? Colors.red : MainColors.backgroundColor2,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.red,
                        )),
                    child: Center(
                      child: Text(
                        "K",
                        style: TextStyle(
                          color: isFemale ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFemale = false;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isFemale ? MainColors.backgroundColor2 : Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: Center(
                    child: Text("E",
                        style: TextStyle(
                          color: isFemale ? Colors.black : Colors.white,
                        )),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  timePicker(Size s) {
    return FadeAnimation(
      1.2,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: s.width * .05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Do??um Tarihiniz:"),
            if (isDateEmpty == true)
              Text(
                "Tarih Se??iniz!",
                style: TextStyle(color: Colors.red),
              ),
            GestureDetector(
              onTap: () {
                selectDate(); // Refer step 3
              },
              child: Container(
                height: s.height * 0.060,
                width: s.width * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: selectedDate == null
                        ? MainColors.softinyoPurple
                        : MainColors.softinyoGreen,
                  ),
                ),
                child: Center(
                  child: Text(
                    selectedDate == null
                        ? "Tarih Se??iniz"
                        : "${selectedDate.year} / ${selectedDate.month} / ${selectedDate.day} ",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
