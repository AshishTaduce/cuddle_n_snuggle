import 'package:cached_network_image/cached_network_image.dart';
import 'package:cns/New%20Screens%202/edit_screen.dart';
import 'package:cns/New%20Screens%202/mypets.dart';
import 'package:cns/New%20Screens%202/register_as_indiviual.dart';
import 'package:flutter/material.dart';
import 'package:cns/models/new_user_model.dart';
import 'package:cns/New%20Screens%202/add_pet_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/src/consumer.dart";

import 'ngo_or_indiviual.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  NewUser? user;

  void _getData() async {
    setState(() {
      loader = true;
    });
    currentUser = firebaseAuth.currentUser!;
    FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: currentUser!.uid)
        .get()
        .then((QuerySnapshot snapshot) async {
      if (snapshot.docs.length <= 0) {
        setState(() {
          user = NewUser.fromDocument(snapshot.docs[0]);
        });
      }
    });

    setState(() {
      loader = false;
    });
  }

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xfffe812d),
        title: Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.power_settings_new,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => RegisterIndiviual()));
        //     },
        //   )
        // ],
        elevation: 0,
      ),
      body: Consumer<MainProvider>(
        builder: (context, info, __) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),

              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 24,
                  child: Text(info.currentUser!.name
                      .toString()
                      .split(" ")
                      .map((e) => e[0])
                      .join("")),
                ),
              ), // cirrent user name
              SizedBox(
                height: 5,
              ),
              Container(
                child: Text(info.currentUser!.name.toString()),
              ),
              SizedBox(
                height: 5,
              ),

              Container(
                child: Text(info.currentUser!.phoneNumber.toString()),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text("Edit Profile"),
                trailing: Icon(Icons.navigate_next),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyPets()));
                },
                title: Text("My Pets"),
                trailing: Icon(Icons.navigate_next),
              ),
              ListTile(
                // my pets and my favs page design same h
                // just add favourite option on pet adoption pets page
                // if anyone clicks on pets heart icon on them then it should come here

                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyPets()));
                },
                title: Text("My Favourites"),

                trailing: Icon(Icons.navigate_next),
              ),
              ListTile(
                title: Text("Location"),
                trailing: Icon(Icons.navigate_next),
              ),
              ListTile(
                title: Text("Setting"),
                trailing: Icon(Icons.navigate_next),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NgoOrIndiviualPage()));
                },
                title: Text("Logout"),
                trailing: Icon(Icons.navigate_next),
              ),
            ],
          ),
        ),
      ),

      // body: loader
      //     ? Center(child: CircularProgressIndicator())
      //     : Consumer<MainProvider>(
      //         builder: (context, info, _) => SingleChildScrollView(
      //           child: Column(
      //             children: [
      //               ListTile(
      //                 leading: CircleAvatar(
      //                   radius: 25,
      //                   backgroundColor: Colors.grey,
      //                 ),
      //                 title: Text(
      //                   currentUser!.displayName.toString(),
      //                  style: TextStyle(//                       fontWeight: FontWeight.bold, fontSize: 18),
      //                 ),
      //                 subtitle: Text(
      //                   currentUser!.email.toString(),
      //                   style: TextStyle(fontSize: 14),
      //                 ),
      //               ),
      //               ListTile(
      //                 contentPadding: EdgeInsets.all(16),
      //                 title: Text(
      //                   "All Pet Match Pets",
      //                  style: TextStyle(//                       fontSize: 18, fontWeight: FontWeight.bold),
      //                 ),
      //                 trailing: IconButton(
      //                   icon: Icon(
      //                     Icons.add,
      //                     color: Colors.black,
      //                     size: 28,
      //                   ),
      //                   onPressed: () async {
      //                     bool res = await Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => AddPetScreen(
      //                                   isAdoption: false,
      //                                 )));
      //                     if (res == true) {
      //                       final snackBar = SnackBar(
      //                         content: Text('Pet Added Successfully'),
      //                       );

      //                       // Find the ScaffoldMessenger in the widget tree
      //                       // and use it to show a SnackBar.
      //                       ScaffoldMessenger.of(context)
      //                           .showSnackBar(snackBar);
      //                     }
      //                   },
      //                 ),
      //               ),
      //               ...info.myPets
      //                   .map(
      //                     (pet) => ListTile(
      //                       contentPadding: EdgeInsets.all(16),
      //                       title: Text(
      //                         pet.petName,
      //                         style: TextStyle(
      //                             fontWeight: FontWeight.bold, fontSize: 18),
      //                       ),
      //                       subtitle: Column(
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text(
      //                             "Age: ${pet.age}",
      //                             style: TextStyle(
      //                               fontSize: 12,
      //                               color: Colors.black,
      //                             ),
      //                           ),
      //                           Text(
      //                             "Sex: ${pet.sex}",
      //                             style: TextStyle(
      //                               fontSize: 12,
      //                               color: Colors.black,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       leading: CircleAvatar(
      //                         backgroundImage: NetworkImage(pet.imageUrl[0]),
      //                       ),
      //                       trailing: IconButton(
      //                         icon: Icon(
      //                           Icons.edit,
      //                           // size: 45,
      //                         ),
      //                         // color: Colors.black,
      //                         onPressed: () => null,
      //                       ),
      //                     ),
      //                   )
      //                   .toList(),
      //               ListTile(
      //                 contentPadding: EdgeInsets.all(16),
      //                 title: Text(
      //                   "All Your Pet Adoption Pets",
      //                   style: TextStyle(
      //                       fontSize: 18, fontWeight: FontWeight.bold),
      //                 ),
      //                 trailing: IconButton(
      //                   icon: Icon(
      //                     Icons.add,
      //                     color: Colors.black,
      //                     size: 28,
      //                   ),
      //                   onPressed: () async {
      //                     bool res = await Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => AddPetScreen(
      //                                   isAdoption: true,
      //                                 )));
      //                     if (res == true) {
      //                       final snackBar = SnackBar(
      //                         content: Text('Pet Added Successfully'),
      //                       );

      //                       ScaffoldMessenger.of(context)
      //                           .showSnackBar(snackBar);
      //                     }
      //                   },
      //                 ),
      //               ),
      //               ...info.myPetAdoptions
      //                   .map(
      //                     (pet) => ListTile(
      //                       contentPadding: EdgeInsets.all(16),
      //                       title: Text(
      //                         pet.petName,
      //                         style: TextStyle(
      //                             fontWeight: FontWeight.bold, fontSize: 18),
      //                       ),
      //                       subtitle: Column(
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text(
      //                             "Age: ${pet.age}",
      //                             style: TextStyle(
      //                               fontSize: 12,
      //                               color: Colors.black,
      //                             ),
      //                           ),
      //                           Text(
      //                             "Sex: ${pet.sex}",
      //                             style: TextStyle(
      //                               fontSize: 12,
      //                               color: Colors.black,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       leading: CircleAvatar(
      //                         backgroundImage: NetworkImage(pet.imageUrl[0]),
      //                       ),
      //                       trailing: IconButton(
      //                         icon: Icon(
      //                           Icons.edit,
      //                           // size: 45,
      //                         ),
      //                         // color: Colors.black,
      //                         onPressed: () {
      //                           Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                   builder: (context) => EditScreen(
      //                                         key: Key(pet.id),
      //                                         currentUser: info.currentUser!,
      //                                       )));
      //                         },
      //                       ),
      //                     ),
      //                   )
      //                   .toList(),
      //               Container(
      //                 width: MediaQuery.of(context).size.width,
      //                 color: Colors.white,
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Align(
      //                     child: Text("Settings"),
      //                     alignment: Alignment.centerLeft,
      //                   ),
      //                 ),
      //                 height: 40,
      //               ),
      //               InkWell(
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(16.0),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Icon(
      //                             Icons.location_on,
      //                             size: 25,
      //                           ),
      //                           SizedBox(
      //                             width: 16,
      //                           ),
      //                           Text(
      //                             "Change Radius",
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.w500,
      //                                 fontSize: 16),
      //                           )
      //                         ],
      //                       ),
      //                       Icon(
      //                         Icons.arrow_forward,
      //                         size: 16,
      //                         color: Colors.grey.withOpacity(0.3),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 onTap: () {},
      //               ),
      //               InkWell(
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(16.0),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Icon(
      //                             Icons.location_on,
      //                             size: 25,
      //                           ),
      //                           SizedBox(
      //                             width: 16,
      //                           ),
      //                           Text(
      //                             "Update Phone Number",
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.w500,
      //                                 fontSize: 16),
      //                           )
      //                         ],
      //                       ),
      //                       Icon(
      //                         Icons.phone_callback,
      //                         size: 16,
      //                         color: Colors.grey.withOpacity(0.3),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 onTap: () {},
      //               ),
      //               InkWell(
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(16.0),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Icon(
      //                             Icons.ios_share,
      //                             size: 25,
      //                           ),
      //                           SizedBox(
      //                             width: 16,
      //                           ),
      //                           Text(
      //                             "Share C&S",
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.w500,
      //                                 fontSize: 16),
      //                           )
      //                         ],
      //                       ),
      //                       Icon(
      //                         Icons.arrow_forward,
      //                         size: 16,
      //                         color: Colors.grey.withOpacity(0.3),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 onTap: () {},
      //               ),
      //               Container(
      //                 width: MediaQuery.of(context).size.width,
      //                 color: Colors.white,
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Text("FAQs"),
      //                 ),
      //                 height: 40,
      //               ),
      //               InkWell(
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(16.0),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Icon(
      //                             Icons.share,
      //                             size: 25,
      //                           ),
      //                           SizedBox(
      //                             width: 16,
      //                           ),
      //                           Text(
      //                             "Follow Us On Social Media",
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.w500,
      //                                 fontSize: 16),
      //                           )
      //                         ],
      //                       ),
      //                       Icon(
      //                         Icons.arrow_forward,
      //                         size: 16,
      //                         color: Colors.grey.withOpacity(0.3),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 onTap: () {},
      //               ),
      //               InkWell(
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(16.0),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Icon(
      //                             Icons.call,
      //                             size: 25,
      //                           ),
      //                           SizedBox(
      //                             width: 16,
      //                           ),
      //                           Text(
      //                             "Contact US",
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.w500,
      //                                 fontSize: 16),
      //                           )
      //                         ],
      //                       ),
      //                       Icon(
      //                         Icons.arrow_forward,
      //                         size: 16,
      //                         color: Colors.grey.withOpacity(0.3),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 onTap: () {},
      //               ),
      //               InkWell(
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(16.0),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Icon(
      //                             Icons.privacy_tip,
      //                             size: 25,
      //                           ),
      //                           SizedBox(
      //                             width: 16,
      //                           ),
      //                           Text(
      //                             "Privacy Policy",
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.w500,
      //                                 fontSize: 16),
      //                           )
      //                         ],
      //                       ),
      //                       Icon(
      //                         Icons.arrow_forward,
      //                         size: 16,
      //                         color: Colors.grey.withOpacity(0.3),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 onTap: () {},
      //               ),
      //               InkWell(
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(16.0),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Icon(
      //                             Icons.info_outline,
      //                             size: 25,
      //                           ),
      //                           SizedBox(
      //                             width: 16,
      //                           ),
      //                           Text(
      //                             "Terms and Condition",
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.w500,
      //                                 fontSize: 16),
      //                           )
      //                         ],
      //                       ),
      //                       Icon(
      //                         Icons.arrow_forward,
      //                         size: 16,
      //                         color: Colors.grey.withOpacity(0.3),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 onTap: () {},
      //               ),
      //               InkWell(
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(16.0),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Icon(
      //                             Icons.info_outline,
      //                             size: 25,
      //                           ),
      //                           SizedBox(
      //                             width: 16,
      //                           ),
      //                           Text(
      //                             "About Us",
      //                             style: TextStyle(
      //                                 fontWeight: FontWeight.w500,
      //                                 fontSize: 16),
      //                           )
      //                         ],
      //                       ),
      //                       Icon(
      //                         Icons.arrow_forward,
      //                         size: 16,
      //                         color: Colors.grey.withOpacity(0.3),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //                 onTap: () {},
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
    );
  }
}
