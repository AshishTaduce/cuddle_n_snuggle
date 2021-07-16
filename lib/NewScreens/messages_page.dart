import 'package:flutter/material.dart';
import 'package:hookup4u2/util/color.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff01b4c9),
      appBar: AppBar(
        backgroundColor: Color(0xff01b4c9),
        automaticallyImplyLeading: false,
        title: Text(
          'Messages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: Text("No Messages")),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Recent messages',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Center(child: Text("No Messages")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
