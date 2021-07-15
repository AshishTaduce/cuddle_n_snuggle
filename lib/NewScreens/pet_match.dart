import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hookup4u2/NewScreens/home_page.dart';
import 'package:hookup4u2/NewScreens/static_chat.dart';
import 'package:hookup4u2/models/user_model.dart';
import 'package:hookup4u2/util/snackbar.dart';

class PetMatch extends StatefulWidget {
  final bool isPaymentSuccess;
  final String plan;
  final String category;
  final String gender;

  const PetMatch(
      {Key key, this.isPaymentSuccess, this.plan, this.category, this.gender})
      : super(key: key);
  @override
  _PetMatchState createState() => _PetMatchState();
}

class _PetMatchState extends State<PetMatch> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CollectionReference collectionReference =
      Firestore.instance.collection("Users");
  @override
  void initState() {
    _getuserList();
    super.initState();
  }

  int totalDoc;
  DocumentSnapshot lastVisible;
  int documentLimit = 25;
  List<User> user = [];
  bool sort = true;
  Future _getuserList() async {
    CollectionReference reference = collectionReference;
    if (widget.category.isNotEmpty) {
      reference.where("category", isEqualTo: widget.category);
    }
    if (widget.gender.isNotEmpty) {
      reference.where("sex",
          isEqualTo: widget.gender.contains("fe") ? "Male" : "Female");
    }
    await reference
        .orderBy("user_DOB", descending: true)
        .getDocuments()
        .then((value) {
      setState(() {
        totalDoc = value.documents.length;
      });
      print("-------------- Users Length -------------");
      print(totalDoc);
    });
    if (totalDoc != null) {
      print("Last Visible is not null");
      print(totalDoc);
      await collectionReference
          .orderBy("user_DOB", descending: true)
          .startAfterDocument(lastVisible)
          .limit(documentLimit)
          .getDocuments()
          .then((value) {
        if (value.documents.length < 1) {
          CustomSnackbar.snackbar("No more data available", _scaffoldKey);
          print("no more data");
          return;
        }
        print(totalDoc);
        lastVisible = value.documents[value.documents.length - 1];
        for (var doc in value.documents) {
          if (doc.data.length > 0) {
            User temp = User.fromDocument(doc);
            user.add(temp);
            print("Data Loading");
          }
        }
      });
    } else {
      print("Last Visible is  null !!!!!");
      print(totalDoc);
      await collectionReference
          .limit(documentLimit)
          .orderBy('user_DOB', descending: true)
          .getDocuments()
          .then((value) {
        lastVisible = value.documents[value.documents.length - 1];
        for (var doc in value.documents) {
          if (doc.data.length > 0) {
            User temp = User.fromDocument(doc);
            user.add(temp);
          }
        }
      });
    }
  }

  TextEditingController searchctrlr = TextEditingController();
  bool isLargeScreen = false;

  Widget userlists(List<User> list) {
    return list.length == 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Center(
                  child: Text(
                    list[index].name.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
            itemCount: list.length,
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
            itemCount: 1,
          );
  }

  final List petInfo = [
    {
      'image':
          "http://cdn.akc.org/content/article-body-image/samoyed_puppy_dog_pictures.jpg",
      'dogname': "Scrubby",
      'petType': 'Dog',
      'petAge': '4',
      'ownerName': 'Animesh',
      'Sex': 'Male',
      'Breed': 'Pomerian'
    },
    {
      'image': "https://i.ytimg.com/vi/MPV2METPeJU/maxresdefault.jpg",
      'dogname': "Niky",
      'petType': 'Dog',
      'petAge': '5',
      'ownerName': 'Pet NGO',
      'Sex': 'Male',
      'Breed': 'Labrador'
    },
    {
      'image':
          "http://cdn.akc.org/content/article-body-image/samoyed_puppy_dog_pictures.jpg",
      'dogname': "Stacy",
      'petType': 'Dog',
      'petAge': '1',
      'ownerName': 'Save Street Pet NGO',
      'Sex': 'Female',
      'Breed': 'Persian Cat'
    },
    {
      'image':
          "https://ichef.bbci.co.uk/news/1024/cpsprodpb/151AB/production/_111434468_gettyimages-1143489763.jpg",
      'dogname': "Scrubby",
      'petType': 'Dog',
      'petAge': '1',
      'ownerName': 'Manya',
      'Sex': 'Female',
      'Breed': 'Persian Cat'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewHomePage(null, null),
              ),
            );
          },
        ),
        title: Text('Pet Match'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: CarouselSlider(
            options: CarouselOptions(
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: false,
              aspectRatio: 1.1,
              viewportFraction: 0.7,
            ),
            items: petInfo
                .map(
                  (item) => Container(
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                item["image"].toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            item["dogname"].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            item["Breed"].toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              item["Sex"] == "Male"
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FaIcon(FontAwesomeIcons.male),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Male")
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FaIcon(FontAwesomeIcons.female),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Female")
                                      ],
                                    ),
                              SizedBox(
                                width: 20,
                              ),
                              FaIcon(FontAwesomeIcons.birthdayCake),
                              Text(
                                " " + item["petAge"] + " years",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StaticChat()));
                              },
                              child: Icon(Icons.message)),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
