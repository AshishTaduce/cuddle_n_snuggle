import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/New%20Screens%202/Welcome_homepage.dart';
import 'package:cns/Screens/auth/otp.dart';
import '../provider/main_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cns/util/color.dart';
import 'package:provider/provider.dart';

class RegisterIndiviual extends StatefulWidget {
  @override
  _RegisterIndiviualState createState() => _RegisterIndiviualState();
}

class _RegisterIndiviualState extends State<RegisterIndiviual> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    Widget background = new Image.asset(
      "asset/semicircle.png",
      fit: BoxFit.fill,
      width: MediaQuery.of(context).size.width,
      height: 250,
    );
    return Scaffold(
      key: _scaffoldKey,
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
                    top: 100.0,

                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Continue",textAlign: TextAlign.center,
                              style: GoogleFonts.merriweather(
                                  fontSize: 25.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text("COntinue registering to be a part",textAlign: TextAlign.center,
                              style: GoogleFonts.merriweather(
                                  fontSize: 15.0,
                                  color: Colors.black,

                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                ),
              ],
            ),


            SizedBox(
              height: 20,
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 18),
            //   child: TextFormField(
            //     controller: nameController,
            //     onChanged: (v) => nameController.text,
            //     decoration: new InputDecoration(
            //       border: new OutlineInputBorder(
            //           borderSide: new BorderSide(color: Colors.teal),
            //           borderRadius: BorderRadius.circular(28.0)
            //           ),
            //       hintText: 'Enter your name',
            //       labelText: 'Name',
            //       prefixIcon: const Icon(
            //         Icons.person,
            //         color: Colors.black,
            //       ),
            //
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 12,
            // ),
            // Container(
            //
            //   padding: EdgeInsets.symmetric(horizontal: 18),
            //   child: TextFormField(
            //     controller: emailController,
            //     onChanged: (v) => emailController.text,
            //
            //     decoration: new InputDecoration(
            //       border: new OutlineInputBorder(
            //           borderSide: new BorderSide(color: Colors.teal),
            //           borderRadius: BorderRadius.circular(28.0),
            //           ),
            //       hintText: 'Enter Your Phone Number',
            //       labelText: 'Phone Number',
            //       prefixIcon: const Icon(
            //         Icons.mail,
            //         color: Color(0xff01b4c9),
            //       ),
            //
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 8,
            // ),
            //
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: TextFormField(
            //     obscureText: true,
            //     controller: passwordController,
            //     onChanged: (v) => passwordController.text,
            //     decoration: new InputDecoration(
            //       border: new OutlineInputBorder(
            //           borderSide: new BorderSide(color: Colors.teal)),
            //       hintText: 'Enter your Password',
            //       labelText: 'Password',
            //       prefixIcon: const Icon(
            //         Icons.lock,
            //         color: Color(0xff01b4c9),
            //       ),
            //       suffixStyle: const TextStyle(color: Colors.green),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 60,
            // ),
            // InkWell(
            //   onTap: () async {
            //     // print("Pressd");
            //     final dynamic res =
            //         await Provider.of<MainProvider>(context, listen: false)
            //             .emailPasswordLogin(
            //       emailController.text.toString(),
            //       passwordController.text.toString(),
            //       nameController.text.toString(),
            //       context,
            //       "Indiviual",
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
            //               primaryColor.withOpacity(.5),
            //               primaryColor.withOpacity(.8),
            //               primaryColor,
            //               primaryColor
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
            //
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    final dynamic res = await Provider.of<MainProvider>(
                            context,
                            listen: false)
                        .handleGoogleSign(context, "Indiviual");
                    if (res == "Success") {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            Future.delayed(Duration(seconds: 3), () async {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NewScreenSecondHomePage(),
                                ),
                              );
                            });
                            return Center(
                                child: Container(
                                    width: 180.0,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          "asset/auth/verified.jpg",
                                          height: 100,
                                        ),
                                        Text(
                                          "Verified\n Successfully",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontSize: 20),
                                        )
                                      ],
                                    )));
                          });
                    } else {
                      // _scaffoldKey.currentState.showSnackBar(SnackBar(
                      //   content: Text('Sign In Failed!'),
                      //   duration: Duration(seconds: 3),
                      // ));
                    }
                  },
                  child: Image.asset(
                    "asset/google.png",
                    height: 35,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () async {
                    final dynamic res = await Provider.of<MainProvider>(
                            context,
                            listen: false)
                        .handleFacebookLogin(context);
                    if (res == "Success") {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          Future.delayed(Duration(seconds: 2), () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NewScreenSecondHomePage(),
                              ),
                            );
                          });
                          return Center(
                            child: Container(
                              width: 180.0,
                              height: 200.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "asset/auth/verified.jpg",
                                    height: 100,
                                  ),
                                  Text(
                                    "Verified\n Successfully",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      // _scaffoldKey.currentState!.showSnackBar(SnackBar(
                      //   content: Text('$res'),
                      //   duration: Duration(seconds: 3),
                      // ));
                    }
                  },
                  child: Image.asset(
                    "asset/fb.png",
                    height: 45
                    ,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    bool updateNumber = false;
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => OTP(updateNumber)));
                  },
                  child: Icon(
                    Icons.message,
                    color: Color(0xff01b4c9),
                    size: 40,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Text(
            //     "Please make sure that you enter the information correctly any misleading information related to your organisation can lead to legal conseqences.",
            //     style: Theme.of(context).textTheme.bodyText1,
            //     textAlign: TextAlign.center,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
