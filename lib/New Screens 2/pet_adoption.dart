import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cns/New%20Screens%202/chat.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';

class PetAdoption extends StatefulWidget {
  @override
  _PetAdoptionState createState() => _PetAdoptionState();
}

class _PetAdoptionState extends State<PetAdoption> {
  // bool exceedSwipes = true;
  bool favourite = false;
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
                            childAspectRatio: 0.8, crossAxisCount: 2),
                        // separatorBuilder: (context, index) {
                        //   return SizedBox(
                        //     height: 10,
                        //   );
                        // },
                        itemCount: currentUser.matchedPetAdoption.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatPage(
                                                currentUser:
                                                    currentUser.currentUser!,
                                                matchedPet: currentUser
                                                    .matchedPetAdoption[index],
                                                chatId: chatId(
                                                  currentUser.currentUser!.id,
                                                  currentUser
                                                      .matchedPetAdoption[index]
                                                      .userId,
                                                ),
                                              ),
                                            ));
                                      },
                                      child: Container(
                                        height: 220,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            alignment: Alignment.centerLeft,
                                            fit: BoxFit
                                                .cover, //I assumed you want to occupy the entire space of the card
                                            image: NetworkImage(
                                              // petInfo.imageUrl[0],
                                              currentUser
                                                  .matchedPetAdoption[index]
                                                  .imageUrl[0]
                                                  .toString(),

                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Opacity(
                                              opacity: 0.77,
                                              child: Container(
                                                height: 47,
                                                decoration: BoxDecoration(
                                                    color: Color(0xfffcc281),
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0))),
                                                child: Consumer<MainProvider>(
                                                  builder:
                                                      (context, info, __) =>
                                                          Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            child: Text(
                                                              info
                                                                  .matchedPetAdoption[
                                                                      index]
                                                                  .petName
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Arial',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  letterSpacing:
                                                                      1.2,
                                                                  fontSize: 17),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                favourite =
                                                                    !favourite;
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 3,
                                                                      right: 3),
                                                              child: !favourite
                                                                  ? Icon(
                                                                      Icons
                                                                          .favorite_border,
                                                                      color: Colors
                                                                          .black,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .favorite_rounded,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        margin: EdgeInsets.only(
                                                            left: 5),
                                                        child: Text(
                                                          info
                                                              .matchedPetAdoption[
                                                                  index]
                                                              .subcategory
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Arial',
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
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
                style: TextStyle(
                    fontFamily: 'MyFont', fontSize: 20, letterSpacing: 1.5),
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

var groupChatId;
chatId(currentUser, sender) {
  if (currentUser.hashCode != sender.hashCode) {
    return groupChatId = '$currentUser-$sender';
  } else {
    return groupChatId = '$sender-$currentUser';
    // return groupChatId = '$sender';
  }
}
