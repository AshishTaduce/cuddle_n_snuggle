import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NewUser {
  final dynamic id; //user id - doc id
  final dynamic name; // ngo name & user ka name
  final dynamic isIndiviual; // indiviual or false
  final dynamic phoneNumber; // phone number
  final dynamic time; // timestamp
  final dynamic userName;
  final dynamic emailaddress; //ngo email
  final dynamic estyear; //ngo year
  final dynamic ngoaddress; // ngo address
  final dynamic ngotype;
  final dynamic ngotiming; //ngo time
  dynamic imageUrl = [];
  NewUser({
    @required this.id,
    @required this.name,
    this.emailaddress,
    this.estyear,
    this.ngoaddress,
    this.ngotype,
    this.ngotiming,
    this.isIndiviual,
    this.time,
    this.userName,
    @required this.imageUrl,
    this.phoneNumber,
  });
  factory NewUser.fromDocument(DocumentSnapshot doc) {
    return doc['isIndiviual'] == 'Indiviual'
        ? NewUser(
      id: doc['userId'],
      phoneNumber: doc['phoneNumber'],
      isIndiviual: doc['isIndiviual'],
      time: doc['timestamp'],
      name: doc['userName'],
      emailaddress: "",
      estyear: "",
      ngoaddress: "",
      ngotiming: "",
      ngotype: "",
      imageUrl: doc['Pictures'] != null
          ? List.generate(doc['Pictures'].length, (index) {
              return doc['Pictures'][index];
            })
          : [],
    )
        : NewUser(
      id: doc['userId'],
      phoneNumber: doc['phoneNumber'],
      isIndiviual: doc['isIndiviual'],
      time: doc['timestamp'],
      name: doc['userName'],
      emailaddress: doc['emailaddress'] ?? "",
      estyear: doc['estyear'],
      ngoaddress: doc['ngoaddress'],
      ngotiming: doc['ngotiming'],
      ngotype: doc['ngotype'],
      imageUrl: doc['Pictures'] != null
          ? List.generate(doc['Pictures'].length, (index) {
        return doc['Pictures'][index];
      })
          : [],
    );
  }
}
