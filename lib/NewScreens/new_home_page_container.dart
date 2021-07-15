import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u2/NewScreens/pet_adoption_grid.dart';
import 'package:hookup4u2/NewScreens/pet_name.dart';
import 'package:hookup4u2/components/custom_dialog.dart';
import 'package:hookup4u2/util/color.dart';

class NewHomePageContainer extends StatefulWidget {
  @override
  _NewHomePageContainerState createState() => _NewHomePageContainerState();
}

class _NewHomePageContainerState extends State<NewHomePageContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Where would you like to go ?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => PetName()));
              },
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
                    "PET MATCH",
                    style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                        fontWeight: FontWeight.bold),
                  ))),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        descriptions: "Want To register for Adoption ?",
                        text: "",
                        title: "",
                        img: Image.asset("asset/ngopagephoto.jpg"),
                      );
                    });
                // Navigator.push(
                //     context,
                //     CupertinoPageRoute(
                //         builder: (context) => PetAdoptionGrid()));
              },
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
                    "ADOPTION",
                    style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                        fontWeight: FontWeight.bold),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
