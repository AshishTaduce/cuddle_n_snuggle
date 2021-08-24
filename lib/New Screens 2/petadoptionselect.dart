import 'dart:io';

import 'package:cns/New%20Screens%202/ngoselection.dart';
import 'package:cns/New%20Screens%202/pet_adoption.dart';
import 'package:flutter/material.dart';

class petAdoptionPageSelect extends StatefulWidget {
  const petAdoptionPageSelect({Key? key}) : super(key: key);

  @override
  _petAdoptionPageSelectState createState() => _petAdoptionPageSelectState();
}

class _petAdoptionPageSelectState extends State<petAdoptionPageSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Mode Of Adoption",
          style: TextStyle(
              fontFamily: 'MyFont', color: Colors.black, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Platform.isIOS
              ? Icon(Icons.navigate_before, size: 30, color: Colors.black)
              : Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PetAdoption()));
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                  image: NetworkImage("https://i.ibb.co/WvFWkF3/1.jpg"),
                )),
                child: Stack(
                  children: [
                    Positioned(
                      right: 10,
                      top: 45,
                      child: Text(
                        "Adopt From \nIndividual",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ngoSelectScreen()));
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                  image: NetworkImage("https://i.ibb.co/9Hy6GXV/2.jpg"),
                )),
                child: Stack(
                  children: [
                    Positioned(
                      right: 10,
                      top: 45,
                      child: Text(
                        "Adopt From \nShelter",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}
