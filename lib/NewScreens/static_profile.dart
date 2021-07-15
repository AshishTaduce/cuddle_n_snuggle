import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u2/Screens/Profile/profile.dart';
import 'package:hookup4u2/Screens/auth/login.dart';
import 'package:hookup4u2/util/color.dart';

class StaticProfile extends StatefulWidget {
  @override
  _StaticProfileState createState() => _StaticProfileState();
}

class _StaticProfileState extends State<StaticProfile> {
  Map<String, dynamic> changeValues = {};
  FirebaseUser currentUser;
  RangeValues ageRange;
  var _showMe;
  bool loading = false;

  int distance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Ads _ads = new Ads();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    getData();
    super.initState();
  }
  getData() async
  {
    setState(() {
      loading = true;
    });
    currentUser = await _auth.currentUser();
   setState(() {
     loading = false;
   });


  }
  @override
  void dispose() {
    // _ads.disable(_ad);

    // _ad?.dispose();
    super.dispose();

    if (changeValues.length > 0) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body:loading?Center(
        child : CircularProgressIndicator()
      ):Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Hero(
                tag: "abc",
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: secondryColor,
                    child: Material(
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          InkWell(
                            // onTap: () => showDialog(
                            //     barrierDismissible: false,
                            //     context: context,
                            //     builder: (context) {
                            //       return Info(widget.currentUser,
                            //           widget.currentUser, null);
                            //     }),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  80,
                                ),
                                child: CachedNetworkImage(
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.fill,
                                  imageUrl:
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxUC64VZctJ0un9UBnbUKtj-blhw02PeDEQIMOqovc215LWYKu&s",
                                  useOldImageOnUrlChange: true,
                                  placeholder: (context, url) =>
                                      CupertinoActivityIndicator(
                                    radius: 15,
                                  ),
                                  errorWidget: (context, url, error) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.error,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      Text(
                                        "Enable to load",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: primaryColor,
                              child: IconButton(
                                  alignment: Alignment.center,
                                  icon: Icon(
                                    Icons.photo_camera,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {}),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                currentUser.displayName.toString(),
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
              // Text(
              //   widget.currentUser.editInfo['job_title'] != null
              //       ? "${widget.currentUser.editInfo['job_title']}  ${widget.currentUser.editInfo['company'] != null ? "at ${widget.currentUser.editInfo['company']}" : ""}"
              //       : "",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       color: Colors.black54,
              //       fontWeight: FontWeight.w400,
              //       fontSize: 20),
              // ),
              Container(
                height: MediaQuery.of(context).size.height * .45,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 70,
                              width: 70,
                              child: FloatingActionButton(
                                  heroTag: UniqueKey(),
                                  splashColor: secondryColor,
                                  backgroundColor: primaryColor,
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    // _editProfileState.source(
                                    //     context, widget.currentUser, false);
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Add media",
                                style: TextStyle(color: secondryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 30, top: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              FloatingActionButton(
                                  splashColor: secondryColor,
                                  heroTag: UniqueKey(),
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.settings,
                                    color: secondryColor,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     CupertinoPageRoute(
                                    //         maintainState: true,
                                    //         builder: (context) => Settings(
                                    //             widget.currentUser,
                                    //             widget.items)));
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Settings",
                                  style: TextStyle(color: secondryColor),
                                ),
                              )
                            ],
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(right: 30, top: 30),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: <Widget>[
                              FloatingActionButton(
                                  heroTag: UniqueKey(),
                                  splashColor: secondryColor,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.edit,
                                    color: secondryColor,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     CupertinoPageRoute(
                                    //         builder: (context) => EditProfile(
                                    //             widget.currentUser)));
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Edit Info",
                                  style: TextStyle(color: secondryColor),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 210),
                      child: Container(
                        height: 120,
                        child: CustomPaint(
                          painter: CurvePainter(),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Logout'),
                                content:
                                    Text('Do you want to logout your account?'),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text('No'),
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      await _auth.signOut().whenComplete(() {
                                        _firebaseMessaging.deleteInstanceID();
                                        Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => Login()),
                                        );
                                      });
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
