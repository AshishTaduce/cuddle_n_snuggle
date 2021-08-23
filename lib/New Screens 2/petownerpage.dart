import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/models/pets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewUser {
  final dynamic id;
  // final dynamic name;
  final dynamic isIndiviual;
  final dynamic phoneNumber;
  final dynamic time;
  String? userName;
  dynamic imageUrl = [];
  NewUser({
    @required this.id,
    // @required this.name,
    this.isIndiviual,
    this.time,
    this.userName,
    @required this.imageUrl,
    this.phoneNumber,
  });
  factory NewUser.fromDocument(DocumentSnapshot doc) {
    String a = doc["userName"];
    print(a);
    return NewUser(
      id: doc['userId'],
      phoneNumber: doc['phoneNumber'],
      isIndiviual: doc['isIndiviual'],
      time: doc['timestamp'],
      userName: doc['userName'],
      imageUrl: doc['Pictures'] != null
          ? List.generate(doc['Pictures'].length, (index) {
              return doc['Pictures'][index];
            })
          : [],
    );
  }
}

class PetOwnerPage extends StatefulWidget {
  final String currentUserid;
  PetOwnerPage({Key? key, required this.currentUserid}) : super(key: key);

  @override
  _PetOwnerPageState createState() => _PetOwnerPageState();
}

class _PetOwnerPageState extends State<PetOwnerPage> {
  List<PetModel> myPets = [];
  List<PetModel> myPetAdoptions = [];

  List<PetModel> petMatches = [];
  List<PetModel> matchesByGender = [];
  List<PetModel> matchedPetAdoption = [];
  late List<String> petCategory;
  late List<String> petSubCategory;
  NewUser? test;
  Future<dynamic> loadUserDetails() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: widget.currentUserid)
        .get()
        .then((QuerySnapshot snapshot) async {
      print(NewUser.fromDocument(snapshot.docs[0]).isIndiviual);

      test = NewUser.fromDocument(snapshot.docs[0]);
    });
    //Pet fetch (//test.id, ) - setStatet
  }

  Future<dynamic> getPets() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('Pets')
          .where('userId', isEqualTo: test!.id)
          .get()
          .then((data) {
        List<PetModel> orders = <PetModel>[];
        List<String> _categories = [];
        List<String> _subCategories = [];

        if (data.docs.isEmpty) {
          myPets = [];
          _categories = [];
          _subCategories = [];
        } else {
          for (int i = 0; i < data.docs.length; i++) {
            orders.add(
              PetModel.fromDocument(data.docs[i], data.docs[i].data(), false),
            );
            _categories.add(data.docs[i]["category"]);
            _subCategories.add(data.docs[i]["subcategory"]);
          }
          petCategory = _categories;
          petSubCategory = _subCategories;
          myPets = orders;
          for (int i = 0; i < _categories.length; i++) {
            updateMatches(
              myPets[i].category.toString(),
              myPets[i].sex.toString() == "Male" ? "Female" : "Male",
              myPets[i].subcategory.toString(),
            );
          }
        }
        setState(() {});
      });
    } catch (e) {
      debugPrint("------- Error from pet adoption ---------");
      throw e;
    }
  }

  Future<dynamic> updateMatches(String cate, String sex, String subcat) async {
    await FirebaseFirestore.instance
        .collection('Pets')
        .where('category', isEqualTo: cate)
        .where('subcategory', isEqualTo: subcat)
        .where('sex', isEqualTo: sex.contains("fe") ? "Male" : "Female")
        .get()
        .then((data) {
      List<PetModel> orders = <PetModel>[];
      int totalCount = data.docs.length;
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < totalCount; i++) {
          print(data.docs[i]["subcategory"]);
          orders.add(
              PetModel.fromDocument(data.docs[i], data.docs[i].data(), false));
        }
        matchesByGender = orders;
        // notifyListeners();
        // print(pet_match[0].category.toString());
      } else {
        print("No data for pet match");
      }
    });
  }

  Future<dynamic> getAdoptionPets() async {
    await FirebaseFirestore.instance
        .collection('PetAdoption')
        .get()
        .then((data) {
      matchedPetAdoption = [];
      petCategory = [];
      petSubCategory = [];

      if (data.docs.isNotEmpty) {
        for (int i = 0; i < data.docs.length; i++) {
          matchedPetAdoption.add(
              PetModel.fromDocument(data.docs[i], data.docs[i].data(), true));
          petCategory.add(data.docs[i]["category"]);
          petSubCategory.add(data.docs[i]["subcategory"]);
        }

        myPetAdoptions = matchedPetAdoption
            .where((element) => element.userId == test!.id)
            .toList();
        matchedPetAdoption = matchedPetAdoption
            .where((element) => element.userId != test!.id)
            .toList();

        for (int i = 0; i < myPetAdoptions.length; i++) {
          updatePetMatches(
            myPetAdoptions[i].category.toString(),
            myPetAdoptions[i].sex.toString() == "Male" ? "Female" : "Male",
            myPetAdoptions[i].subcategory.toString(),
          );
        }

        // notifyListeners();
      }
      setState(() {});
    });
  }

  Future<dynamic> updatePetMatches(
      String _category, String sex, String _subCategory) async {
    await FirebaseFirestore.instance
        .collection('PetAdoption')
        .get()
        .then((data) {
      List<PetModel> orders = <PetModel>[];
      int totalCount = data.docs.length;
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < totalCount; i++) {
          orders.add(
              PetModel.fromDocument(data.docs[i], data.docs[i].data(), true));
          orders =
              orders.where((element) => element.userId != test!.id).toList();
          matchedPetAdoption = orders;
        }
      } else {
        print("No Pet Adoption");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserDetails();
    getAdoptionPets();
    getPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: test == null
              ? Container(
                  color: Colors.yellow,
                )
              : Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 180,
                          color: Color(0xfffcc281),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              CircleAvatar(
                                radius: 30,
                                child: Text(
                                  test!.userName
                                      .toString()
                                      .split(" ")
                                      .map((e) => e[0])
                                      .join(""),
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(test!.userName.toString()),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Pet Adoption Pets - " +
                                  myPetAdoptions.length.toString()),
                              SizedBox(
                                height: 3,
                              ),
                              Text("Pet Match Pets - " +
                                  myPets.length.toString())
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Positioned(
                            top: 30,
                            left: 10,
                            child: Icon(
                              Icons.navigate_before,
                              size: 35,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pet Match Pets",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pet Adoption Pets",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// on tap of any of the pets .. pet detail page should open
// dont worry about design i will do that aap bass data call kardo
// for image make it in grid of axis count 2
