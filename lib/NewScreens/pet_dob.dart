import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u2/NewScreens/pet_category.dart';
import 'package:hookup4u2/util/color.dart';

class PetDOB extends StatefulWidget {
  @override
  _PetDOBState createState() => _PetDOBState();
}

class _PetDOBState extends State<PetDOB> {
  // String userDOB = '';
  dynamic userData = {};
  DateTime selecteddate;
  TextEditingController dobctlr = new TextEditingController();
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
                      "My Pets \nbirthday is on",
                      style: TextStyle(fontSize: 40),
                    ),
                    padding: EdgeInsets.only(left: 50, top: 120),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                      child: ListTile(
                    title: CupertinoTextField(
                      readOnly: true,
                      keyboardType: TextInputType.phone,
                      prefix: IconButton(
                        icon: (Icon(
                          Icons.calendar_today,
                          color: primaryColor,
                        )),
                        onPressed: () {},
                      ),
                      onTap: () => showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                height:
                                    MediaQuery.of(context).size.height * .25,
                                child: GestureDetector(
                                  child: CupertinoDatePicker(
                                    backgroundColor: Colors.white,
                                    initialDateTime: DateTime(2000, 10, 12),
                                    onDateTimeChanged: (DateTime newdate) {
                                      setState(() {
                                        dobctlr.text = newdate.day.toString() +
                                            '/' +
                                            newdate.month.toString() +
                                            '/' +
                                            newdate.year.toString();
                                        selecteddate = newdate;
                                      });
                                    },
                                    maximumYear: DateTime.now().year,
                                    minimumYear: 1800,
                                    maximumDate: DateTime.now(),
                                    mode: CupertinoDatePickerMode.date,
                                  ),
                                  onTap: () {
                                    print(dobctlr.text);
                                    Navigator.pop(context);
                                  },
                                ));
                          }),
                      placeholder: "DD/MM/YYYY",
                      controller: dobctlr,
                    ),
                    subtitle: Text(" Your age will be public"),
                  ))),
              dobctlr.text.length > 0
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
                            userData.addAll({
                              'user_DOB': "$selecteddate",
                              'age': ((DateTime.now()
                                          .difference(selecteddate)
                                          .inDays) /
                                      365.2425)
                                  .truncate(),
                            });
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => PetCategory(
                                        // userData: widget.userData,
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
