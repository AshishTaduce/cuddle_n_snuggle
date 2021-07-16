import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u2/Screens/UserName.dart';
import 'package:hookup4u2/Screens/pet_age.dart';
import 'package:hookup4u2/util/color.dart';

class CatBreeds extends StatefulWidget {
  @override
  _CatBreedsState createState() => _CatBreedsState();
}

class _CatBreedsState extends State<CatBreeds> {
  List dogBreeds = [
    "Persian cat",
    "Maine Coon",
    "Bengal cat",
    "British Shorthair",
    "Siamese cat"
  ];
  dynamic dogBredds = "Persian cat";
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
      body: Container(
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  dogBreeds[index].toString(),
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_right_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => UserName(),
                    ),
                  );
                },
              );
            },
            itemCount: dogBreeds.length,
          ),
        ),
      ),
    );
  }
}
