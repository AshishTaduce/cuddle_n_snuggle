import 'package:flutter/material.dart';
import 'package:hookup4u2/util/color.dart';

class StaticChat extends StatefulWidget {
  @override
  _StaticChatState createState() => _StaticChatState();
}

class _StaticChatState extends State<StaticChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                width: MediaQuery.of(context).size.width * 0.65,
                margin: EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 80.0, right: 10),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              "Your Dog is Awesome",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              DateTime.now().day.toString() +
                                  "/" +
                                  DateTime.now().month.toString() +
                                  "/" +
                                  DateTime.now().year.toString(),
                              style: TextStyle(
                                color: secondryColor,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.done_all,
                              color: primaryColor,
                              size: 15,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ));
          },
        ));
  }
}
