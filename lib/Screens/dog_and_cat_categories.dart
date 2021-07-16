import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u2/Screens/DogBreeds.dart';
import 'package:hookup4u2/Screens/cat_breeds.dart';
import 'package:hookup4u2/util/color.dart';

class DogAndCatCategories extends StatefulWidget {
  @override
  _DogAndCatCategoriesState createState() => _DogAndCatCategoriesState();
}

class _DogAndCatCategoriesState extends State<DogAndCatCategories> {
  Map<String, dynamic> userData = {}; //user personal info
  String username = '';

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
                      "",
                      style: TextStyle(fontSize: 40),
                    ),
                    padding: EdgeInsets.only(left: 50, top: 120),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  child: Text(
                    "Choose your pet category.",
                    style: TextStyle(fontSize: 23),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // DogBreeds
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => DogBreeds(),
                            ),
                          );
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
                              "DOG",
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
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CatBreeds(),
                            ),
                          );
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
                              "CAT",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
