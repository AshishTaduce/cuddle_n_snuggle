import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cns/New%20Screens%202/mypets.dart';
import 'package:cns/New%20Screens%202/petadoptionselect.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cns/New Screens 2/Calenderx.dart';
import 'package:cns/New Screens 2/carouselnews.dart';
import 'package:cns/New%20Screens%202/Message_page.dart';
import 'package:cns/New%20Screens%202/notification_page.dart';
import 'package:cns/New%20Screens%202/pet_adoption.dart';
import 'package:cns/New%20Screens%202/pet_match_select.dart';
import 'package:cns/New%20Screens%202/profilen.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';

class NewScreenSecondHomePage extends StatefulWidget {
  @override
  _NewScreenSecondHomePageState createState() =>
      _NewScreenSecondHomePageState();
}

class _NewScreenSecondHomePageState extends State<NewScreenSecondHomePage>
    with AutomaticKeepAliveClientMixin {


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color(0xffff9827),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.calendar_today_outlined, title: 'Calendar'),
          TabItem(icon: Icons.message, title: 'Message'),

          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 0, //optional, default as 0

        onTap: (index) {
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewScreenSecondHomePage()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CalenderPage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MessagePage()));
          } else if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          }
        },
      ),
      body: FirebaseAuth.instance.currentUser == null
          ? Center(
              child: Container(
                height: 60,
                child: CircularProgressIndicator(),
              ),
            )
          : HomePageBottomBar()
          // : PageView(
          //     key: Key("A"),
          //     // controller: _pageController,
          //     children: [
          //       HomePageBottomBar(),
          //       CalenderPage(),
          //       MessagePage(),
          //       ProfileScreen(),
          //     ],
          //     // onPageChanged: (page) {
          //     //   _menuPositionController.absolutePosition = _pageController.page;
          //     // },
          //   ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomePageBottomBar extends StatefulWidget {
  @override
  _HomePageBottomBarState createState() => _HomePageBottomBarState();
}

class _HomePageBottomBarState extends State<HomePageBottomBar> {
  // int selectedpage = 0;
  // final pageoption = [
  //   NewScreenSecondHomePage(),
  //   CalenderPage(),
  //   MessagePage(),
  //   ProfileScreen()
  // ];
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "We Missed You",
            style: TextStyle(
                fontSize: 30, fontFamily: 'Myfont', color: Colors.black),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationPage(),
                  ),
                );
              },
              child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black,
                  )),
            )
          ],
          iconTheme: IconThemeData(color: Colors.black),
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     children: [
        //       Consumer<MainProvider>(
        //         builder: (context, info, __) => UserAccountsDrawerHeader(
        //           decoration: BoxDecoration(
        //             color: Color(0xfffcc281),
        //           ),
        //           accountName: Text(
        //             info.currentUser!.name,
        //             style: TextStyle(
        //                 color: Colors.black,
        //                 letterSpacing: 1.2,
        //                 fontSize: 20,
        //                 fontFamily: 'Arial',
        //                 fontWeight: FontWeight.bold),
        //           ),
        //           accountEmail: Text(
        //             info.currentUser!.phoneNumber == null
        //                 ? ""
        //                 : info.currentUser!.phoneNumber,
        //             style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 18,
        //                 letterSpacing: 1.2,
        //                 fontFamily: 'Arial',
        //                 fontWeight: FontWeight.bold),
        //           ),
        //           currentAccountPicture: CircleAvatar(
        //             // backgroundColor: Color(0xfffcc281),
        //             child: Text(
        //               info.currentUser!.name
        //                   .toString()
        //                   .split(" ")
        //                   .map((e) => e[0])
        //                   .join(""),
        //               style: TextStyle(fontSize: 30.0),
        //             ),
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => NewScreenSecondHomePage()));
        //         },
        //         title: Text(
        //           "Home",
        //           style: TextStyle(
        //               fontFamily: 'Arial',
        //               letterSpacing: 1.2,
        //               fontWeight: FontWeight.bold),
        //         ),
        //         leading: Icon(Icons.home),
        //       ),
        //       ListTile(
        //         onTap: () {},
        //         title: Text(
        //           "My Favourites",
        //           style: TextStyle(
        //               fontFamily: 'Arial',
        //               letterSpacing: 1.2,
        //               fontWeight: FontWeight.bold),
        //         ),
        //         leading: Icon(Icons.favorite),
        //       ),
        //       ListTile(
        //         onTap: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => MyPets()));
        //         },
        //         title: Text(
        //           "My Pets",
        //           style: TextStyle(
        //               fontFamily: 'Arial',
        //               letterSpacing: 1.2,
        //               fontWeight: FontWeight.bold),
        //         ),
        //         leading: Icon(Icons.home),
        //       ),
        //       Divider(
        //         thickness: 1.0,
        //       ),
        //       ListTile(
        //           onTap: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => CalenderPage()));
        //           },
        //           title: Text(
        //             "Calendar",
        //             style: TextStyle(
        //                 fontFamily: 'Arial',
        //                 letterSpacing: 1.2,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //           leading: Icon(Icons.calendar_today)),
        //       ListTile(
        //         onTap: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => MessagePage()));
        //         },
        //         title: Text(
        //           "Messages",
        //           style: TextStyle(
        //               fontFamily: 'Arial',
        //               letterSpacing: 1.2,
        //               fontWeight: FontWeight.bold),
        //         ),
        //         leading: Icon(Icons.message),
        //       ),
        //       ListTile(
        //         onTap: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => ProfileScreen()));
        //         },
        //         title: Text(
        //           "Profile",
        //           style: TextStyle(
        //               fontFamily: 'Arial',
        //               letterSpacing: 1.2,
        //               fontWeight: FontWeight.bold),
        //         ),
        //         leading: Icon(Icons.person),
        //       )
        //     ],
        //   ),
        // ),
        body: FirebaseAuth.instance.currentUser == null
            ? Center(
          child: Container(
            height: 60,
            child: CircularProgressIndicator(),
          ),
        ):
        SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [


              SizedBox(
                height: 40,
              ),
              Consumer<MainProvider>(
                builder: (context, acc, __) => Row(
                  children: [
                    if (acc.currentUser != null && acc.currentUser!.isIndiviual == "Indiviual")
                    Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PetMatchSelect(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffff9827),
                                Color(0xfffcc281),
                              ],
                            ),
                          ),
                          child: Consumer<MainProvider>(
                            builder: (context, acc, __) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 16.0),
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      // color: Colors.white,
                                    ),
                                    child: SvgPicture.asset(
                                      "asset/mating.svg",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Pet Match",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetAdoptionPageSelect(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xffff9827),
                              Color(0xfffcc281),
                            ],
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 16.0),
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  // color: Colors.white,
                                ),
                                child: SvgPicture.asset(
                                  "asset/adoption.svg",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Pet Adoption",
                                  style: GoogleFonts.nunito(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Expanded(
              //               child: Text(
              //             "Where would you like to go ?",
              //             textAlign: TextAlign.center,
              //             style: GoogleFonts.nunito(
              //               fontSize: 24,
              //               color: Colors.black,
              //               fontStyle: FontStyle.normal,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           )),
              //         ],
              //       ),
              //       SizedBox(
              //         height: 15,
              //       ),
              //       Row(
              //         children: [
              //           Expanded(
              //               child: InkWell(
              //             onTap: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => PetMatchSelect(),
              //                 ),
              //               );
              //             },
              //             child: Container(
              //               height: 150,
              //               width: 150,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(16.0),
              //                 gradient: LinearGradient(
              //                   colors: [Color(0xff1fa2ea), Color(0xff1fa2ea)],
              //                 ),
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: <Widget>[
              //                   Padding(
              //                     padding: const EdgeInsets.only(
              //                         left: 16.0, right: 16.0, top: 16.0),
              //                     child: Container(
              //                       height: 45,
              //                       width: 45,
              //                       decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(16.0),
              //                         color: Colors.white,
              //                       ),
              //                       child: Icon(Icons.pets_rounded),
              //                     ),
              //                   ),
              //                   Expanded(
              //                     child: Align(
              //                       alignment: Alignment.center,
              //                       child: Text(
              //                         "Pet Match",
              //                         style: GoogleFonts.abrilFatface(
              //                           fontSize: 18.0,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           )),
              //           SizedBox(
              //             width: 40,
              //           ),
              //           Expanded(
              //               child: InkWell(
              //             onTap: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => PetAdoption(),
              //                 ),
              //               );
              //             },
              //             child: Container(
              //               height: 150,
              //               width: 150,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(16.0),
              //                 gradient: LinearGradient(
              //                   colors: [Color(0xff1fa2ea), Color(0xff1fa2ea)],
              //                 ),
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: <Widget>[
              //                   Padding(
              //                     padding: const EdgeInsets.only(
              //                         left: 16.0, right: 16.0, top: 16.0),
              //                     child: Container(
              //                       height: 45,
              //                       width: 45,
              //                       decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(16.0),
              //                         color: Colors.white,
              //                       ),
              //                       child: Icon(Icons.home_filled),
              //                     ),
              //                   ),
              //                   Expanded(
              //                     child: Align(
              //                       alignment: Alignment.center,
              //                       child: Text(
              //                         "Pet Adoption",
              //                         style: GoogleFonts.nunito(
              //                           fontSize: 18.0,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           )),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20, // Pets loading code below commented
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     children: [
              //       Text(
              //         "Latest News",
              //         textAlign: TextAlign.start,
              //         style: GoogleFonts.nunito(
              //           fontSize: 24,
              //           color: Colors.black,
              //           fontStyle: FontStyle.normal,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(25.0),
              //     ),
              //     child: CarouselSlider(
              //       options: CarouselOptions(
              //         aspectRatio: 2.0,
              //         enlargeCenterPage: true,
              //         enableInfiniteScroll: true,
              //         initialPage: 2,
              //         autoPlay: true,
              //       ),
              //       items: imageSliders,
              //     )),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     children: [
              //       Text(
              //         "Technology",
              //         textAlign: TextAlign.start,
              //         style: GoogleFonts.nunito(
              //           fontSize: 24,
              //           color: Colors.black,
              //           fontStyle: FontStyle.normal,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //     child: CarouselSlider(
              //   options: CarouselOptions(
              //     aspectRatio: 2.0,
              //     enlargeCenterPage: true,
              //     enableInfiniteScroll: true,
              //     initialPage: 2,
              //     autoPlay: true,
              //   ),
              //   items: imageSliders,
              // ))

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     children: [
              //       Text(
              //         "Manage your Pets Here",
              //         textAlign: TextAlign.start,
              //         style: GoogleFonts.nunito(
              //           fontSize: 24,
              //           color: Colors.black,
              //           fontStyle: FontStyle.normal,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 12,
              // ),
              // Consumer<MainProvider>(
              //   builder: (_, pets, __) {
              //     return pets.petsmodel == null
              //         ? SizedBox(
              //             height: 40,
              //             child: InkWell(
              //               onTap: () {
              //                 print("AddPet");
              //                 Navigator.push(context,
              //                     MaterialPageRoute(builder: (context) => AddPet()));
              //               },
              //               child: SizedBox(
              //                 height: 50,
              //                 child: ElevatedButton(
              //                   onPressed: () {
              //                     Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                             builder: (context) => AddPet()));
              //                   },
              //                   child: Icon(
              //                     Icons.add_outlined,
              //                     color: Colors.black,
              //                     size: 30,
              //                   ),
              //                   style: ButtonStyle(
              //                     backgroundColor:
              //                         MaterialStateProperty.all<Color>(Colors.white),
              //                     foregroundColor:
              //                         MaterialStateProperty.all<Color>(Colors.white),
              //                     shape: MaterialStateProperty.all<
              //                         RoundedRectangleBorder>(
              //                       RoundedRectangleBorder(
              //                           borderRadius: BorderRadius.circular(90),
              //                           side: BorderSide(color: Colors.black)),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           )
              //         : Container(
              //             height: 120,
              //             child: ListView.separated(
              //               separatorBuilder: (_, __) {
              //                 return SizedBox(
              //                   width: 15,
              //                 );
              //               },
              //               padding: EdgeInsets.all(10),
              //               itemCount: pets.petsmodel.length == 0
              //                   ? 1
              //                   : pets.petsmodel.length + 1,
              //               itemBuilder: (context, index) {
              //                 if (index == pets.petsmodel.length) {
              //                   return SizedBox(
              //                     height: 50,
              //                     child: InkWell(
              //                       onTap: () {
              //                         print("AddPet");
              //                         Navigator.push(
              //                             context,
              //                             MaterialPageRoute(
              //                                 builder: (context) => AddPet()));
              //                       },
              //                       child: SizedBox(
              //                         height: 50,
              //                         child: ElevatedButton(
              //                           onPressed: () {
              //                             Navigator.push(
              //                                 context,
              //                                 MaterialPageRoute(
              //                                     builder: (context) => AddPet()));
              //                           },
              //                           child: Icon(
              //                             Icons.add_outlined,
              //                             color: Colors.black,
              //                             size: 40,
              //                           ),
              //                           style: ButtonStyle(
              //                             backgroundColor:
              //                                 MaterialStateProperty.all<Color>(
              //                                     Colors.white),
              //                             foregroundColor:
              //                                 MaterialStateProperty.all<Color>(
              //                                     Colors.white),
              //                             shape: MaterialStateProperty.all<
              //                                 RoundedRectangleBorder>(
              //                               RoundedRectangleBorder(
              //                                   borderRadius:
              //                                       BorderRadius.circular(50),
              //                                   side:
              //                                       BorderSide(color: Colors.black)),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   );
              //                 }
              //                 return Container(
              //                   child: InkWell(
              //                     onTap: () async {
              //                       await Provider.of<MainProvider>(context,
              //                               listen: false)
              //                           .petDetailId(
              //                               pets.petsmodel[index].id.toString());
              //                       Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                           builder: (context) => EditProfile(
              //                             e: pets.petsmodel[index],
              //                             documentId:
              //                                 pets.petsmodel[index].id.toString(),
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                     child: CircleAvatar(
              //                       radius: 50,
              //                       backgroundImage: NetworkImage(
              //                         pets.petsmodel[index].imageUrl[0].toString(),
              //                       ),
              //                       backgroundColor: Color(0xffa8bcfb).withOpacity(0.4),
              //                     ),
              //                   ),
              //                 );
              //               },
              //               scrollDirection: Axis.horizontal,
              //             ),
              //           );
              //   },
              // ),
              // SizedBox(
              //   height: 4,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     children: [
              //       Text(
              //         "Add Yor Pet For Adoption",
              //         textAlign: TextAlign.start,
              //         style: GoogleFonts.nunito(
              //           fontSize: 24,
              //           color: Colors.black,
              //           fontWeight: FontWeight.bold,
              //           fontStyle: FontStyle.normal,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 12,
              // ),
              // Consumer<MainProvider>(
              //   builder: (_, petsadoption, __) {
              //     return petsadoption.pet_adoption_model == null
              //         ? SizedBox(
              //           height: 50,
              //             child: InkWell(
              //             onTap: () {
              //               print("Pet Adoption");
              //               Navigator.push(context,
              //               MaterialPageRoute(builder: (context) => AddPetAdoption()));
              //         },
              //               child: SizedBox(
              //           height: 30,
              //           child: ElevatedButton(
              //             onPressed: () {
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => AddPet()));
              //             },
              //             child: Icon(
              //               Icons.add_outlined,
              //               color: Colors.black,
              //               size: 40,
              //             ),
              //             style: ButtonStyle(
              //               backgroundColor:
              //               MaterialStateProperty.all<Color>(Colors.white),
              //               foregroundColor:
              //               MaterialStateProperty.all<Color>(Colors.white),
              //               shape: MaterialStateProperty.all<
              //                   RoundedRectangleBorder>(
              //                 RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(50),
              //                     side: BorderSide(color: Colors.black)),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     )
              //         : Container(
              //       height: 120,
              //       child: ListView.separated(
              //         separatorBuilder: (_, __) {
              //           return SizedBox(
              //             width: 15,
              //           );
              //         },
              //         padding: EdgeInsets.all(10),
              //         itemCount: petsadoption.pet_adoption_model.length == 0
              //             ? 1
              //             : petsadoption.pet_adoption_model.length + 1,
              //         itemBuilder: (context, index) {
              //           if (index == petsadoption.pet_adoption_model.length) {
              //             return SizedBox(
              //               height: 50,
              //               child: InkWell(
              //                 onTap: () {
              //                   print("AddPet Pet Adoption");
              //                   Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                           builder: (context) => AddPetAdoption()));
              //                 },
              //                 child: SizedBox(
              //                   height: 50,
              //                   child: ElevatedButton(
              //                     onPressed: () {
              //                       Navigator.push(
              //                           context,
              //                           MaterialPageRoute(
              //                               builder: (context) => AddPetAdoption()));
              //                       },
              //                     child: Icon(
              //                       Icons.add_outlined,
              //                       color: Colors.black,
              //                       size: 40,
              //                     ),
              //                     style: ButtonStyle(
              //                       backgroundColor:
              //                       MaterialStateProperty.all<Color>(
              //                           Colors.white),
              //                       foregroundColor:
              //                       MaterialStateProperty.all<Color>(
              //                           Colors.white),
              //                       shape: MaterialStateProperty.all<
              //                           RoundedRectangleBorder>(
              //                         RoundedRectangleBorder(
              //                             borderRadius:
              //                             BorderRadius.circular(50),
              //                             side:
              //                             BorderSide(color: Colors.black)),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           }
              //           return Container(
              //             child: InkWell(
              //               onTap: () async {
              //                 await Provider.of<MainProvider>(context,
              //                     listen: false)
              //                     .Petadoptiondetail(
              //                     petsadoption.pet_adoption_model[index].id.toString());
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                     builder: (context) => AdoptionEdit(
              //                       e: petsadoption.pet_adoption_model[index],
              //                       documentId:
              //                       petsadoption.pet_adoption_model[index].id.toString(),
              //                     ),
              //                   ),
              //                 );
              //               },
              //               child: CircleAvatar(
              //                 radius: 50,
              //                 backgroundImage: NetworkImage(
              //                   petsadoption.pet_adoption_model[index].imageUrl[0].toString(),
              //                 ),
              //                 backgroundColor: Color(0xffa8bcfb).withOpacity(0.4),
              //               ),
              //             ),
              //           );
              //         },
              //         scrollDirection: Axis.horizontal,
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }


}


