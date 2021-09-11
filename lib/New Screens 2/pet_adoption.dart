import 'dart:io';

import 'package:cns/models/pets.dart';
import 'package:flutter/material.dart';
import 'package:cns/New%20Screens%202/chat.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';


class PetAdoption extends StatefulWidget {
  @override
  _PetAdoptionState createState() => _PetAdoptionState();
}

class _PetAdoptionState extends State<PetAdoption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GradientAppBar("Pet Adoption"),
                Consumer<MainProvider>(
                  builder: (_, currentUser, __) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 2 * 200,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8,
                          crossAxisCount: 2,
                        ),
                        itemCount: currentUser.matchedPetAdoption.length,
                        itemBuilder: (context, index) {
                          PetModel pet = currentUser.matchedPetAdoption[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                        currentUser: currentUser.currentUser!,
                                        matchedPet: currentUser.matchedPetAdoption[index],
                                        chatId: chatId(
                                          currentUser.currentUser!.id,
                                          currentUser.matchedPetAdoption[index].userId,
                                        ),
                                      ),
                                    ));
                              },
                              child: Container(
                                height: 220,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover, //I assumed you want to occupy the entire space of the card
                                    image: NetworkImage(
                                      
                                      // petInfo.imageUrl[0],
                                      currentUser.matchedPetAdoption[index].imageUrl[0].toString(),
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Opacity(
                                      opacity: 0.77,
                                      child: Container(
                                        height: 47,
                                        decoration: BoxDecoration(
                                          color: Color(0xfffcc281),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(left: 5),
                                                  child: Text(
                                                    pet.petName.toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 1.2,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    currentUser.favouritePets.any((_pet) => _pet.id == pet.id)
                                                        ? currentUser.favouritePets.remove(pet)
                                                        : currentUser.favouritePets.add(pet);
                                                    //TODO: Add pets to firebase.
                                                    currentUser.updateValues();
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: 3, right: 3),
                                                    child: currentUser.favouritePets.any(
                                                      (_pet) => _pet.id == pet.id,
                                                    )
                                                        ? Icon(
                                                            Icons.favorite_rounded,
                                                            color: Colors.red,
                                                          )
                                                        : Icon(
                                                            Icons.favorite_border,
                                                            color: Colors.black,
                                                          ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(left: 5),
                                              child: Text(
                                                pet.subcategory.toString(),
                                                style: TextStyle(fontFamily: 'Arial', fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            IconButton(
              icon: Platform.isIOS
                  ? Icon(
                      Icons.navigate_before,
                      size: 30,
                    )
                  : Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 15,
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(fontFamily: 'MyFont', fontSize: 20, letterSpacing: 1.5),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // begin: Alignment.topRight,
          // end: Alignment.bottomLeft,
          colors: [
            // Color(0xffff9827),
            // Color(0xfffcc281),

            Colors.white,
            Colors.white
          ],
        ),
      ),
    );
  }
}

chatId(currentUser, sender) {
  if (currentUser.hashCode != sender.hashCode) {
    return '$currentUser-$sender';
  } else {
    return '$sender-$currentUser';
    // return groupChatId = '$sender';
  }
}
