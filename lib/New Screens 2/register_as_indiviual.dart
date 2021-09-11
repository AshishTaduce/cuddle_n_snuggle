import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/New%20Screens%202/Welcome_homepage.dart';
import 'package:cns/Screens/auth/otp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import '../provider/main_provider.dart';
import 'package:provider/provider.dart';

class RegisterIndiviual extends StatefulWidget {
  @override
  _RegisterIndiviualState createState() => _RegisterIndiviualState();
}

class _RegisterIndiviualState extends State<RegisterIndiviual> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = new TextEditingController();
  String countryCode = '+91';
  bool cont = false;

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
      "asset/sc.png",
      fit: BoxFit.fill,
      width: MediaQuery.of(context).size.width,
      height: 200,
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
                    top: 55.0,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Myfont',
                                  fontSize: 29.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Continue registering to be a part",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
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
                            //       ),
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
                  "Enter Your Name",
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
                  hintText: 'John Doe',
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mobile Number",
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
                  hintText: '123-456-7890',
                ),
                keyboardType: TextInputType.number,
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
              onPressed: () {},
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    final dynamic res =
                        await Provider.of<MainProvider>(context, listen: false)
                            .handleGoogleSign(context, "Indiviual");
                    if (res == "Success") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NewScreenSecondHomePage(),
                        ),
                      );
                    } else {
                      // _scaffoldKey.currentState.showSnackBar(SnackBar(
                      //   content: Text('Sign In Failed!'),
                      //   duration: Duration(seconds: 3),
                      // ));
                    }
                  },
                  child: Image.asset(
                    "asset/google.png",
                    height: 45,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),

                InkWell(
                  onTap: () async {
                    final dynamic res =
                        await Provider.of<MainProvider>(context, listen: false)
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
                    "asset/facebook.png",
                    height: 45,
                  ),
                ),

                // InkWell(
                //   onTap: () {
                //     bool updateNumber = false;
                //     Navigator.push(
                //         context,
                //         CupertinoPageRoute(
                //             builder: (context) => OTP(updateNumber)));
                //   },
                //   child: Icon(
                //     Icons.message,
                //     color: Color(0xff01b4c9),
                //     size: 40,
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Image.asset("asset/doggy.png",
                  width: MediaQuery.of(context).size.width / 1.1),
            )
          ],
        ),
      ),
    );
  }
}
