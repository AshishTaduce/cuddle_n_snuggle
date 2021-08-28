
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ngoexisting extends StatefulWidget {
  const ngoexisting({Key? key}) : super(key: key);

  @override
  _ngoexistingState createState() => _ngoexistingState();
}

class _ngoexistingState extends State<ngoexisting> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
          mainAxisAlignment: MainAxisAlignment.start,
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
                              "Login as NGO",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Myfont',
                                  fontSize: 29.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Continue were you left us",
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
                  "Email Address",
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
                controller: email,
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
                  hintText: 'johndoe@example.com',
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
                  "Enter Your Password",
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
                controller: password,
                obscureText: true,
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
                  hintText: '**********',
                ),
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
                  text: "Continue",
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
                pf.setString("email", email.text);

                pf.setString("password", password.text);


              },
            ),
            // SizedBox(
            //   height: 30,
            // ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "asset/below.png",
                fit: BoxFit.contain,
              ),
            )

            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: TextFormField(
            //     controller: namengo,
            //     onChanged: (v) => namengo.text,
            //     decoration: new InputDecoration(
            //       border: new OutlineInputBorder(
            //           borderSide: new BorderSide(color: Colors.teal)),
            //       hintText: 'Enter The Name of NGO',
            //       labelText: 'Name of NGO',
            //       prefixIcon: const Icon(
            //         Icons.home_outlined,
            //         color: Color(0xff01b4c9),
            //       ),
            //       suffixStyle: const TextStyle(color: Colors.green),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 6,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: TextFormField(
            //     controller: addressngo,
            //     onChanged: (v) => addressngo.text,
            //     decoration: new InputDecoration(
            //       border: new OutlineInputBorder(
            //           borderSide: new BorderSide(color: Colors.teal)),
            //       hintText: 'Enter address of NGO',
            //       labelText: 'Address',
            //       prefixIcon: const Icon(
            //         Icons.location_on,
            //         color: Color(0xff01b4c9),
            //       ),
            //       suffixStyle: const TextStyle(color: Colors.green),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 6,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: TextFormField(
            //     controller: ownername,
            //     onChanged: (v) => ownername.text,
            //     decoration: new InputDecoration(
            //       border: new OutlineInputBorder(
            //           borderSide: new BorderSide(color: Colors.teal)),
            //       hintText: 'Enter the Name of Authorized Person',
            //       labelText: 'Authorized Person',
            //       prefixIcon: const Icon(
            //         Icons.person_rounded,
            //         color: Color(0xff01b4c9),
            //       ),
            //       suffixStyle: const TextStyle(color: Colors.green),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 6,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: TextFormField(
            //     controller: email,
            //     onChanged: (v) => email.text,
            //     decoration: new InputDecoration(
            //       border: new OutlineInputBorder(
            //           borderSide: new BorderSide(color: Colors.teal)),
            //       hintText: 'Enter your email',
            //       labelText: 'Email Id',
            //       prefixIcon: const Icon(
            //         Icons.mail,
            //         color: Color(0xff01b4c9),
            //       ),
            //       suffixStyle: const TextStyle(color: Colors.green),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 6,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: TextFormField(
            //     controller: password,
            //     onChanged: (v) => password.text,
            //     decoration: new InputDecoration(
            //       border: new OutlineInputBorder(
            //           borderSide: new BorderSide(color: Colors.teal)),
            //       hintText: 'Enter a Password',
            //       labelText: 'Password',
            //       prefixIcon: const Icon(
            //         Icons.mail,
            //         color: Color(0xff01b4c9),
            //       ),
            //       suffixStyle: const TextStyle(color: Colors.green),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 50,
            // ),
            // InkWell(
            //   onTap: () async {
            //     final dynamic res =
            //         await Provider.of<MainProvider>(context, listen: false)
            //             .emailPasswordLogin(
            //       email.text.toString(),
            //       password.text.toString(),
            //       ownername.text.toString(),
            //       context,
            //       "Ngo",
            //     );
            //     print(res);
            //     if (res == "New User") {
            //       showDialog(
            //           barrierDismissible: false,
            //           context: context,
            //           builder: (_) {
            //             Future.delayed(Duration(seconds: 2), () async {
            //               Navigator.pushReplacement(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (BuildContext context) =>
            //                       NewScreenSecondHomePage(),
            //                 ),
            //               );
            //             });
            //             return Center(
            //                 child: Container(
            //                     width: 180.0,
            //                     height: 200.0,
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         shape: BoxShape.rectangle,
            //                         borderRadius: BorderRadius.circular(20)),
            //                     child: Column(
            //                       children: <Widget>[
            //                         Image.asset(
            //                           "asset/auth/verified.jpg",
            //                           height: 100,
            //                         ),
            //                         Text(
            //                           "Verified\n Successfully",
            //                           textAlign: TextAlign.center,
            //                           style: TextStyle(
            //                               decoration: TextDecoration.none,
            //                               color: Colors.black,
            //                               fontSize: 20),
            //                         )
            //                       ],
            //                     )));
            //           });
            //     } else {
            //       _scaffoldKey.currentState.showSnackBar(SnackBar(
            //         content: Text('Sign In Failed!'),
            //         duration: Duration(seconds: 3),
            //       ));
            //     }
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //         shape: BoxShape.rectangle,
            //         borderRadius: BorderRadius.circular(25),
            //         gradient: LinearGradient(
            //             begin: Alignment.topRight,
            //             end: Alignment.bottomLeft,
            //             colors: [
            //               Color(0xff01b4c9),
            //               Color(0xff01b4c9),
            //             ])),
            //     height: MediaQuery.of(context).size.height * .065,
            //     width: MediaQuery.of(context).size.width * .75,
            //     child: Center(
            //       child: Text(
            //         "Continue",
            //         style: TextStyle(
            //             fontSize: 15,
            //             color: textColor,
            //             fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            // ),

            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   "OR",
            //   style: TextStyle(fontSize: 18),
            //   textAlign: TextAlign.center,
            // ),
            // SizedBox(
            //   height: 10,
            // ),
          ],
        ),
      ),
    );
  }
}
