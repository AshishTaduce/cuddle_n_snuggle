


import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cns/widget/messaging_widget.dart';

class NotificationPage extends StatelessWidget {
  final String appTitle = 'Firebase messaging';
  @override
  Widget build(BuildContext context) {
    return MainPage(appTitle: "Hi");
  }

}

class MainPage extends StatelessWidget {
  final String appTitle;

  const MainPage({required this.appTitle});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      elevation: 0,
      title: Text("Notifications",style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        fontFamily: "MyFont",
        color: Colors.black
      ),),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    ),
    body: MessagingWidget(),
  );
}

