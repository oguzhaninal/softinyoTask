import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:softinyo_task/animation.dart';
import 'package:softinyo_task/config/cities.dart';
import 'package:softinyo_task/config/colors.dart';
import 'package:softinyo_task/navigationBar/navigationBar.dart';
import 'package:softinyo_task/widgets/centerLogo.dart';
import 'package:softinyo_task/widgets/myButton.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String city;
  String town;
  int selectedCityIndex = 0;
  bool isCitySelected = false;
  int a;
  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return SafeArea(
      child: FadeAnimation(
        1.2,
        Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CenterLogo(),
                  alignText(phoneSize, "Hoş geldiniz.."),
                  alignText(phoneSize,
                      "Devam etmek için lütfen hobi ve yetenek seçiniz"),
                  cityList(phoneSize),
                  townList(phoneSize),
                  MyButton(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => NavigationBar(0),
                      ),
                    );
                  }, phoneSize, "Onayla"),
                  city == null ? Text("Seçtiğiniz Şehir") : Text(city),
                  town == null ? Text("Seçtiğiniz İlçe") : Text(town),
                ],
              ),
            ),
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

  townList(Size phoneSize) {
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
              readOnly: !isCitySelected,
              items: [
                for (int j = 0; j < Cities.towns[selectedCityIndex].length; j++)
                  DropdownMenuItem<String>(
                    value: Cities.towns[selectedCityIndex][j],
                    child: Text(Cities.towns[selectedCityIndex][j]),
                  )
              ],
              clearIcon: Icon(FlutterIcons.clear_mdi,
                  color: MainColors.softinyoPurple),
              isExpanded: true,
              hint: Text("İlçe Seç"),
              searchHint: Text("Bir ilçe arayın.."),
              closeButton: "Kapat",
              value: town,
              underline: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: phoneSize.width * .025),
                child: Container(
                    height: phoneSize.height * .002,
                    color: MainColors.softinyoGreen),
              ),
              onChanged: (String newValue) {
                print(newValue);
                setState(() {
                  town = newValue;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  cityList(Size phoneSize) {
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
              items: [
                for (int i = 0; i < Cities.cities.length; i++)
                  DropdownMenuItem<String>(
                    value: Cities.cities[i],
                    child: Text(Cities.cities[i]),
                  )
              ],
              clearIcon: Icon(FlutterIcons.clear_mdi,
                  color: MainColors.softinyoPurple),
              isExpanded: true,
              hint: Text("Şehir Seç"),
              searchHint: Text("Bir şehir arayın.."),
              closeButton: "Kapat",
              value: city,
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
                  selectedCityIndex = Cities.cities.indexOf(newValue);
                  isCitySelected = true;
                  city = newValue;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
