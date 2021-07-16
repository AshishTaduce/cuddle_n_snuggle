import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u2/Screens/want_to_play_date.dart';
import 'package:hookup4u2/util/color.dart';

import 'AllowLocation.dart';

class WantToAdopt extends StatefulWidget {
  final dynamic userData;

  const WantToAdopt({Key key, this.userData}) : super(key: key);
  @override
  _WantToAdoptState createState() => _WantToAdoptState();
}

class _WantToAdoptState extends State<WantToAdopt> {
  Map<String, dynamic> userData = {}; //user personal info
  String wantToAdopt = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 50),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: FloatingActionButton(
            elevation: 10,
            child: IconButton(
              color: secondryColor,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white38,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    child: Text(
                      "Do you want to register for Adoption?",
                      style: TextStyle(fontSize: 40),
                    ),
                    padding: EdgeInsets.only(left: 50, top: 120),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    wantToAdopt = "Yes";
                  });
                  userData.addAll({'WantToAdopt': "$wantToAdopt"});
                  print("============ UserAdoption ==================");
                  print(userData);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              AllowLocation(widget.userData)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                primaryColor.withOpacity(.5),
                                primaryColor.withOpacity(.8),
                                primaryColor,
                                primaryColor
                              ])),
                      height: MediaQuery.of(context).size.height * .065,
                      width: MediaQuery.of(context).size.width * .75,
                      child: Center(
                          child: Text(
                        "YES",
                        style: TextStyle(
                            fontSize: 15,
                            color: textColor,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    wantToAdopt = "No";
                  });
                  userData.addAll({'UserName': "$wantToAdopt"});
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => WantToPlayDate(
                                userData: widget.userData,
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                primaryColor.withOpacity(.5),
                                primaryColor.withOpacity(.8),
                                primaryColor,
                                primaryColor
                              ])),
                      height: MediaQuery.of(context).size.height * .065,
                      width: MediaQuery.of(context).size.width * .75,
                      child: Center(
                          child: Text(
                        "NO",
                        style: TextStyle(
                            fontSize: 15,
                            color: textColor,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
