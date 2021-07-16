import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u2/Screens/owner_name.dart';
import 'package:hookup4u2/util/color.dart';

class PetAge extends StatefulWidget {
  final dynamic userData;

  const PetAge({Key key, this.userData}) : super(key: key);
  @override
  _PetAgeState createState() => _PetAgeState();
}

class _PetAgeState extends State<PetAge> {
  Map<String, dynamic> userData = {};
  String username = '';
  @override
  void initState() {
    print(widget.userData);
    super.initState();
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    child: Text(
                      "My Pets\nage is",
                      style: TextStyle(fontSize: 40),
                    ),
                    padding: EdgeInsets.only(left: 50, top: 120),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  child: TextFormField(
                    // keyboardType: ,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 23),
                    decoration: InputDecoration(
                      hintText: "Enter your Pet Age",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      helperText: "This is how it will appear in App.",
                      helperStyle:
                          TextStyle(color: secondryColor, fontSize: 15),
                    ),
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                  ),
                ),
              ),
              username.length > 0
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
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
                                "CONTINUE",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                          onTap: () {
                            widget.userData.addAll({'PetAge': "$username"});
                            print(widget.userData);
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => OwnerName(
                                          userData: widget.userData,
                                        )));
                          },
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              height: MediaQuery.of(context).size.height * .065,
                              width: MediaQuery.of(context).size.width * .75,
                              child: Center(
                                  child: Text(
                                "CONTINUE",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: secondryColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                          onTap: () {},
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
