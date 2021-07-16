import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:cns/util/color.dart';

import 'package:provider/provider.dart';
import 'New Screens 2/Welcome_homepage.dart';
import 'New Screens 2/ngo_or_indiviual.dart';
import 'Screens/Splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutternotificationplugin = FlutterLocalNotificationsPlugin();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AndroidInitializationSettings initialisationAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initialisationIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, String? title, String? body, String? payload) async {});
  var initialisationSetting = InitializationSettings(android: initialisationAndroid, iOS: initialisationIOS);
  await flutternotificationplugin.initialize(initialisationSetting, onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload' + payload);
    }
  });

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
        ],
        child: new MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  bool isAuth = false;
  bool isRegistered = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future _checkAuth() async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: user.uid)
          .get()
          .then((QuerySnapshot snapshot) async {
        if (snapshot.docs.length > 0) {
          if ((snapshot.docs[0].data() as Map)['location'] != null) {
            setState(() {
              isRegistered = true;
              isLoading = false;
            });
          } else {
            setState(() {
              isAuth = true;
              isLoading = false;
            });
          }
          print("loggedin ${user.uid}");
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    await Provider.of<MainProvider>(context, listen: false).loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: isLoading
          ? Splash()
          : isRegistered
              ? NewScreenSecondHomePage() //NewScreenSecondHomePage()
              : isAuth
                  ? NewScreenSecondHomePage() //NewScreenSecondHomePage()
                  : NgoOrIndiviualPage(),
    );
  }
}


//For info.plist of iOS Build (Camera permission and privacy declaration.)
// <key>NSPhotoLibraryUsageDescription</key>
// <string>Permission required for app to pick image files.</string>
// <key>NSCameraUsageDescription</key>
// <string>Permission required to click images.</string>
// <key>NSMicrophoneUsageDescription</key>
// <string>Permission required for proper working of camera.</string>