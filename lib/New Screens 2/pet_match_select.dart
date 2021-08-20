import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'add_pet_screen.dart';
import 'pet_match.dart';

class PetMatchSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: HexColor("#f7f7f7"),
      appBar: AppBar(
        backgroundColor: HexColor("#f7f7f7"),
        leading: IconButton(
          icon: Icon(Icons.chevron_left_rounded),
          iconSize: 36,
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        title: Text(
          "Select The Pet",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
        ),
      ),
      body: Consumer<MainProvider>(
        builder: (_, currentUser, __) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ...currentUser.myPets
                  .map(
                    (petInfo) => InkWell(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PetMatchScreen(
                            category: petInfo.category,
                            subcategory: petInfo.subcategory,
                            gender: petInfo.sex,
                            selectedPetID: petInfo.id,
                          ),
                        ),
                      ),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.cover, //I assumed you want to occupy the entire space of the card
                              image: NetworkImage(
                                // petInfo.imageUrl[0],
                                "https://images.unsplash.com/photo-1591946559594-8c6d3b7391eb?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=MnwxfDB8MXxyYW5kb218MHx8ZG9nfHx8fHx8MTYyOTA0Mjk0Nw&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1600"
                              ),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: 5,
                                top: 25,
                                child: Container(
                                  width: 140,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        petInfo.petName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: Text(
                                          petInfo.sex + " " + petInfo.category,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                          petInfo.about,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            Icons.add_circle_outline,
                            size: 32,
                            color: HexColor("#ffec40"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Add New",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPetScreen(
                      isAdoption: false,
                    ),
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
