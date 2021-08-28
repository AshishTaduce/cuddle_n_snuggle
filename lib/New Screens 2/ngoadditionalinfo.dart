import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/New%20Screens%202/Welcome_homepage.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ngoAdditionalInfo extends StatefulWidget {
  const ngoAdditionalInfo({Key? key}) : super(key: key);

  @override
  _ngoAdditionalInfoState createState() => _ngoAdditionalInfoState();
}

class _ngoAdditionalInfoState extends State<ngoAdditionalInfo> {
  TextEditingController ngoname = TextEditingController();
  TextEditingController ngoaddress = TextEditingController();
  TextEditingController ngotype = TextEditingController();
  TextEditingController estyear = TextEditingController();
  TextEditingController ngotiming = TextEditingController();
  String? email;
  String? phone;
  String? password;

  @override
  Widget build(BuildContext context) {
    Widget background = new Image.asset(
      "asset/sc.png",
      fit: BoxFit.fill,
      width: MediaQuery.of(context).size.width,
      height: 200,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                background,
                Positioned(
                    top: 34,
                    child: IconButton(
                      icon: Platform.isIOS
                          ? Icon(
                              Icons.navigate_before,
                              size: 32,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.arrow_back,
                              size: 32,
                              color: Colors.white,
                            ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Positioned(
                    top: 55.0,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Few More Details",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Myfont',
                                  fontSize: 29.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Small Things help us know better",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  "NGO Name",
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial'),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 55,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: ngoname,
                decoration: InputDecoration(
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  hintText: 'Animal Heaven',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  "NGO Address",
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial'),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 55,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: ngoaddress,
                decoration: InputDecoration(
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  hintText: 'A - 131, Vasant Kunj, Delhi',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  "NGO Type",
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial'),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 55,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: ngotype,
                decoration: InputDecoration(
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  hintText: 'Category of Your NGO',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Established Year",
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial'),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 55,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: estyear,
                decoration: InputDecoration(
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  hintText: '2021',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  "NGO Timings",
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial'),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 55,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: ngotiming,
                decoration: InputDecoration(
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(
                      color: Colors.white54,
                    ),
                  ),
                  hintText: '8 AM - 6 PM',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ProgressButton.icon(
              height: 45.0,
              minWidth: MediaQuery.of(context).size.width * 0.7,
              iconedButtons: {
                ButtonState.idle: IconedButton(
                  text: "Join Us",
                  icon:
                      Icon(Icons.app_registration_rounded, color: Colors.white),
                  color: Color(0xffff9827),
                ),
                ButtonState.loading: IconedButton(
                  text: "Loading",
                  color: Colors.deepPurple.shade700,
                ),
                ButtonState.fail: IconedButton(
                  text: "Invalid Values",
                  icon: Icon(Icons.cancel, color: Colors.white),
                  color: Colors.red.shade300,
                ),
                ButtonState.success: IconedButton(
                    text: "Success",
                    icon: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade400)
              },
              onPressed: () async {
                SharedPreferences pf = await SharedPreferences.getInstance();
                password = pf.getString("password");
                email = pf.getString("email");
                phone = pf.getString("phonenumber");
                pf.setString("ngoname", ngoname.text);
                pf.setString("ngoaddress", ngoaddress.text);
                pf.setString("ngotiming", ngotiming.text);
                pf.setString("ngotype", ngotype.text);
                pf.setString("estyr", estyear.text);
                print(pf.getString("ngoname"));
                // await ngoSignUp(email!, password!);
                // await Future.delayed(Duration(seconds: 3));
                await Provider.of<MainProvider>(context, listen: false)
                    .ngoSignUp({
                  "email": email,
                  "password": password,
                  "ngoaddress": ngoaddress.text,
                  "ngoname": ngoname.text,
                  "ngotiming": ngotiming.text,
                  "ngotype": ngotype.text,
                  "estyear": estyear.text,
                  "phone": phone
                });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewScreenSecondHomePage()));
              },
            ),
            SizedBox(
              height: 30,
            ),

            Container(

              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("asset/below.png",fit: BoxFit.contain,),
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: () async {
            //         final dynamic res =
            //             await Provider.of<MainProvider>(context, listen: false)
            //                 .handleGoogleSignNGO(context, "NGO");
            //         if (res == "Success") {
            //           showDialog(
            //               barrierDismissible: false,
            //               context: context,
            //               builder: (_) {
            //                 Future.delayed(Duration(seconds: 1), () async {
            //                   Navigator.pushReplacement(
            //                     context,
            //                     MaterialPageRoute(
            //                       builder: (BuildContext context) =>
            //                           NewScreenSecondHomePage(),
            //                     ),
            //                   );
            //                 });
            //                 return Center(
            //                     child: Container(
            //                         width: 180.0,
            //                         height: 200.0,
            //                         decoration: BoxDecoration(
            //                             color: Colors.white,
            //                             shape: BoxShape.rectangle,
            //                             borderRadius:
            //                                 BorderRadius.circular(20)),
            //                         child: Column(
            //                           children: <Widget>[
            //                             Image.asset(
            //                               "asset/auth/verified.jpg",
            //                               height: 100,
            //                             ),
            //                             Text(
            //                               "Verified\n Successfully",
            //                               textAlign: TextAlign.center,
            //                               style: TextStyle(
            //                                   decoration: TextDecoration.none,
            //                                   color: Colors.black,
            //                                   fontSize: 20),
            //                             )
            //                           ],
            //                         )));
            //               });
            //         } else {
            //           // _scaffoldKey.currentState.showSnackBar(SnackBar(
            //           //   content: Text('Sign In Failed!'),
            //           //   duration: Duration(seconds: 3),
            //           // ));
            //         }
            //       },
            //       child: Image.asset(
            //         "asset/google.png",
            //         height: 35,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 15,
            //     ),
            //     InkWell(
            //       onTap: () async {
            //         final dynamic res =
            //             await Provider.of<MainProvider>(context, listen: false)
            //                 .handleFacebookLogin(context);
            //         if (res == "Success") {
            //           showDialog(
            //             barrierDismissible: false,
            //             context: context,
            //             builder: (_) {
            //               Future.delayed(Duration(seconds: 2), () async {
            //                 Navigator.pushReplacement(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (BuildContext context) =>
            //                         NewScreenSecondHomePage(),
            //                   ),
            //                 );
            //               });
            //               return Center(
            //                 child: Container(
            //                   width: 180.0,
            //                   height: 200.0,
            //                   decoration: BoxDecoration(
            //                       color: Colors.white,
            //                       shape: BoxShape.rectangle,
            //                       borderRadius: BorderRadius.circular(20)),
            //                   child: Column(
            //                     children: <Widget>[
            //                       Image.asset(
            //                         "asset/auth/verified.jpg",
            //                         height: 100,
            //                       ),
            //                       Text(
            //                         "Verified\n Successfully",
            //                         textAlign: TextAlign.center,
            //                         style: TextStyle(
            //                             decoration: TextDecoration.none,
            //                             color: Colors.black,
            //                             fontSize: 20),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               );
            //             },
            //           );
            //         } else {
            //           // _scaffoldKey.currentState.showSnackBar(SnackBar(
            //           //   content: Text('$res'),
            //           //   duration: Duration(seconds: 3),
            //           // ));
            //         }
            //       },
            //       child: Image.asset(
            //         "asset/fb.png",
            //         height: 45,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 15,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
