import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:curved_splash_screen/curved_splash_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    load_functions();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void load_functions() async {
    await Provider.of<MainProvider>(context, listen: false).decideSplash();
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Color(0xff01b4c9),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash()
    );
  }
}

