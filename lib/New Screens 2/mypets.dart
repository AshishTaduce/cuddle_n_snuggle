import 'package:cns/New%20Screens%202/edit_your_pet_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'add_pet_screen.dart';
import 'pet_match.dart';

class MyPets extends StatelessWidget {
  bool showFavourites = false;
  MyPets(this.showFavourites);

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
          showFavourites ? "My Favourites" : "My Pets",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
        ),
      ),
      body: Consumer<MainProvider>(
        builder: (_, currentUser, __) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3 / 4,
            ),
            children: [
              if (!showFavourites)
                ...currentUser.myPets
                    .map(
                      (petInfo) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                      e: petInfo, documentId: petInfo.userId)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    petInfo.imageUrl[0],
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                    alignment: Alignment.center,
                                    semanticLabel: petInfo.petName,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Text(
                                    petInfo.petName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  petInfo.subcategory,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              if (!showFavourites)
                ...currentUser.myPetAdoptions
                    .map(
                      (petInfo) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  petInfo.imageUrl[0],
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center,
                                  semanticLabel: petInfo.petName,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Text(
                                  petInfo.petName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),

              if (showFavourites)
                ...currentUser.favouritePets
                    .map(
                      (petInfo) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  petInfo.imageUrl[0],
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center,
                                  semanticLabel: petInfo.petName,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Text(
                                  petInfo.petName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),

              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(32.0),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Center(
              //           child: Icon(
              //             Icons.add_circle_outline,
              //             size: 32,
              //             color: HexColor("#ffec40"),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 8.0),
              //           child: Text(
              //             "Add New",
              //             style: TextStyle(
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
