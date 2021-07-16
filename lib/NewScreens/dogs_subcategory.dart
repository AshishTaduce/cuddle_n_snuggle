import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u2/NewScreens/my_pet_is.dart';
import 'package:hookup4u2/util/color.dart';

class DogsCategory extends StatefulWidget {
  @override
  _DogsCategoryState createState() => _DogsCategoryState();
}

class _DogsCategoryState extends State<DogsCategory> {
  List dogBreeds = [
    "German Shepherd",
    "Bulldog",
    "Poodle",
    "Labrador Retriever",
    "Golden Retriever"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: InkWell(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => PetSex(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(top: 100),
          child: Center(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.all(15),
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
                      dogBreeds[index].toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: textColor,
                          fontWeight: FontWeight.bold),
                    )));
              },
              itemCount: dogBreeds.length,
            ),
          ),
        ),
      ),
    );
  }
}

// onTap: () {
//                   Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                       builder: (context) => PetSex(),
//                     ),
//                   );
//                 },
