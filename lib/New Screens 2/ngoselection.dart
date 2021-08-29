import 'dart:io';

import 'package:cns/New%20Screens%202/petownerpage.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'dart:io';

class NGOSelectScreen extends StatefulWidget {
  NGOSelectScreen({Key? key}) : super(key: key);

  @override
  _NGOSelectScreenState createState() => _NGOSelectScreenState();
}

class _NGOSelectScreenState extends State<NGOSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Platform.isIOS
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.navigate_before,
                  color: Colors.black,
                ),
              )
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Ngo",
          style: TextStyle(color: Colors.black, fontFamily: 'MyFont', letterSpacing: 1.2),
        ),
      ),
      body: Consumer<MainProvider>(builder: (context, currentUser, __) {
        print(currentUser.ngoUsers);
        return currentUser.ngoUsers == []
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    ...currentUser.ngoUsers
                        .map(
                          (ngoinfo) => InkWell(
                            onTap: () {
                              final snackBar = SnackBar(
                                content: const Text(' Building NGO Page now'),
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );

                              // Find the ScaffoldMessenger in the widget tree
                              // and use it to show a SnackBar.
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              print(ngoinfo.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PetOwnerPage(
                                    currentUserid: ngoinfo.id,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2.0,
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
                                        "https://images.unsplash.com/photo-1577407371215-693fce1c5181?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fG5nb3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
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
                                              ngoinfo.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 24,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                                              child: Text(
                                                "Est Yr -" + ngoinfo.estyear,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ngoinfo.ngoaddress,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
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
                  ],
                ),
              );
      }),
    );
  }
}
