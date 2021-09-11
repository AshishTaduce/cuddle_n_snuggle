import 'dart:io';

import 'package:cns/New%20Screens%202/pet_match_select.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerifyOTP extends StatefulWidget {
  VerifyOTP({Key? key}) : super(key: key);

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  @override
  void initState() {
    super.initState();
    // verifyphone();
  }

  late String _verificationCode;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "asset/sc.png",
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                ),
                Positioned(
                    top: 14,
                    child: IconButton(
                      icon: Platform.isIOS
                          ? Icon(
                              Icons.navigate_before,
                              size: 30,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.arrow_back,
                              size: 30,
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
                              "Verify OTP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Myfont',
                                  fontSize: 29.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Please check your message",
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
              height: MediaQuery.of(context).size.height / 10,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: PinPut(
                  fieldsCount: 6,
                  textStyle:
                      const TextStyle(fontSize: 25.0, color: Colors.black),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 45.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.rotation,
                  onSubmit: (pin) async {}),
            ),
          ],
        ),
      )),
    );
  }
}

//  verifyphone() async {
//    await FirebaseAuth.instance.verifyPhoneNumber(
//      phoneNumber: '+918851590289', 
//     //  verificationCompleted: verificationCompleted,
//     //   verificationFailed: verificationFailed, 
//     //   codeSent: codeSent,
//     //    codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
       
//        )
// }
