import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softinyo_task/config/colors.dart';
import 'package:softinyo_task/models/userModel.dart';
import 'package:softinyo_task/screens/setInfoScreen.dart';

import '../../animation.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File uploadedImage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FadeAnimation(
        1.2,
        Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  icon: Icon(FlutterIcons.settings_fea, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SetInfoPage(
                                  isSetting: true,
                                  text1: "Merhaba",
                                  text2: "Bilgilerinizi güncelleyin",
                                )));
                  })
            ],
            automaticallyImplyLeading: false,
            title: Text("Profil"),
          ),
          body: Column(
            children: [profile()],
          ),
        ),
      ),
    );
  }

  profile() {
    Size s = MediaQuery.of(context).size;
    return FadeAnimation(
      1.2,
      Padding(
        padding: EdgeInsets.only(top: s.width * .15),
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 10, bottom: 10, top: 10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ]),
          height: s.height * .65,
          child: Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      height: s.height * .4,
                      width: s.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: uploadedImage == null
                                ? AssetImage("assets/images/noImage.jpg")
                                : FileImage(uploadedImage)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -5,
                      right: 10,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          size: s.width * .1,
                          color: MainColors.softinyoPurple,
                        ),
                        onPressed: () => uploadFromCam(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: s.height * .015, bottom: s.height * .0221),
                  child: Container(
                    width: s.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoText(
                            s,
                            UserModel.instance.id == null
                                ? "Kullanıcı ID'si"
                                : UserModel.instance.id.toString()),
                        infoText(
                            s,
                            UserModel.instance.fName == null
                                ? "Kullanıcı adı"
                                : UserModel.instance.fName),
                        infoText(
                            s,
                            UserModel.instance.sName == null
                                ? "Kullanıcı Soyadı"
                                : UserModel.instance.sName),
                        infoText(
                          s,
                          UserModel.instance.bornDate == null
                              ? " Doğum Tarihi"
                              : UserModel.instance.bornDate.toString(),
                        ),
                        infoText(
                            s,
                            UserModel.instance.email == null
                                ? "Kullanıcı E-Postası"
                                : UserModel.instance.email),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: s.width,
                  height: s.height * .05,
                  decoration: BoxDecoration(
                      color: UserModel.instance.gender == "1"
                          ? Colors.red
                          : Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding infoText(Size s, String text) {
    return Padding(
      padding: EdgeInsets.only(left: s.width * .05, bottom: s.height * .01),
      child: Text(text),
    );
  }

  Future uploadFromCam() async {
    final ppic = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      uploadedImage = File(ppic.path);
    });
  }
}
