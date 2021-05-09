import 'dart:async';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softinyo_task/animation.dart';
import 'package:softinyo_task/config/colors.dart';
import 'package:softinyo_task/navigationBar/navigationBar.dart';
import 'package:softinyo_task/widgets/centerLogo.dart';
import 'screens/registerPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: MainColors.backgroundColor2,
        fontFamily: "DMSans",
        appBarTheme: AppBarTheme(
          color: MainColors.softinyoPurple,
        ),
      ),
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String outputText = " ";

  @override
  void initState() {
    super.initState();
    startTimer();
    oneSignal();
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.2,
      Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CenterLogo(),
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: MainColors.softinyoPurple,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  startTimer() {
    Timer(Duration(seconds: 2), () {
      navigateUser();
    });
  }

  navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool("isLoggedIn") ?? true;

    if (status) {
      // userToken = prefs.getString("token");
      // uName = prefs.getString("username");
      // userId = prefs.getString("userid");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => NavigationBar(0),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => RegisterPage(),
        ),
      );
    }
  }

  void oneSignal() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init(
      "ff72070b-01e0-4a0c-a35f-3294964b1cd4",
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: false
      },
    );
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }
}
