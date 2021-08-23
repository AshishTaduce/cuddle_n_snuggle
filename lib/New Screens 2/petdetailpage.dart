import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/New%20Screens%202/petownerpage.dart';
import 'package:cns/models/new_user_model.dart';
import 'package:cns/models/pets.dart';
import 'package:flutter/material.dart';

class PetDetailPage extends StatefulWidget {
  final PetModel matchedPet;
  // final NewUser currentUser;

  PetDetailPage({
    Key? key,
    // required this.currentUser,
    required this.matchedPet,
  }) : super(key: key);

  @override
  _PetDetailPageState createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              Stack(
                children: [
                  Container(
                    // all the image of pet should be shown in carousel
                    // height: 250,
                    margin: EdgeInsets.all(10.0),

                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: CarouselSlider(
                        items: widget.matchedPet.imageUrl
                            .map((e) => Container(
                                  color: Colors.red,
                                  child: Image.network(
                                    e,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            viewportFraction: 1,
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: true),
                      ),
                      // child: Image.network(
                      //   // "https://images.unsplash.com/photo-1586671267731-da2cf3ceeb80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80"
                      //   widget.matchedPet.imageUrl[1],
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.navigate_before,
                        size: 34,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        size: 34,
                      ),
                      color: Colors.red,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  // check why  heart is not coming
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.matchedPet.petName.toUpperCase(),
                  style: TextStyle(
                      letterSpacing: 1.2,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Color(0xfffcc281)),
                    margin: EdgeInsets.only(left: 3),
                    child: Column(
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.matchedPet.category,
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              letterSpacing: 1.2),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Color(0xfffcc281)),
                    // margin: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Text(
                          "Breed",
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.matchedPet.subcategory,
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              letterSpacing: 1.2),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Color(0xfffcc281)),
                    // margin: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Text(
                          "BirthDate",
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.matchedPet.petdob,
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              letterSpacing: 1.2),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Color(0xfffcc281)),
                    margin: EdgeInsets.only(right: 3),
                    child: Column(
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.matchedPet.sex,
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 16,
                              letterSpacing: 1.2),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial',
                      fontSize: 16,
                      letterSpacing: 1.2),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  widget.matchedPet.about,
                  style: TextStyle(
                      fontFamily: 'Arial', fontSize: 14, letterSpacing: 1.2),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xfffcc281),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PetOwnerPage(
                          currentUserid: widget.matchedPet.userId,
                        )));
          },
          label: Text("View Pet Owner")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
