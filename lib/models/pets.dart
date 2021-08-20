import 'package:cloud_firestore/cloud_firestore.dart';

class PetModel {
  final dynamic userId;
  final dynamic id;
  final dynamic petName;
  final dynamic category;
  final dynamic petdob;
  final dynamic subcategory;
  final dynamic sex;
  final dynamic age;
  final dynamic about;
  final dynamic vaccinated;
  final dynamic kssiCertified;
  List<String> imageUrl = [];
  bool isAdoption;

  PetModel({
    this.userId,
    this.about,
    this.age,
    this.vaccinated,
    this.kssiCertified,
    this.id,
    this.petName,
    this.category,
    this.petdob,
    this.subcategory,
    this.sex,
    required this.imageUrl,
    required this.isAdoption,
  });

  Map <String, dynamic> toJson () {
    return {
      "userId": userId,
      "petName": petName,
      "imageUrl": imageUrl.toString(),
      "id": id,

    };
  }

  factory PetModel.fromDocument(DocumentSnapshot doc, dynamic docId, _isAdoption) {
    return PetModel(
      userId: doc['userId'],
      petName: doc['name'],
      category: doc['category'],
      petdob: doc['petdob'],
      sex: doc['sex'],
      subcategory: doc['subcategory'],
      age: ((DateTime.now().difference(DateTime.parse(doc["petdob"])).inDays) /
              365.2425)
          .truncate(),
      about: doc['bio'],
      kssiCertified: doc['kssi_certified'],
      vaccinated: doc['vaccinated'],
      imageUrl: List.generate(
              doc['image'].length,
              (index) {
                return doc['image'][index];
              },
            ),
      id: doc.id, isAdoption: _isAdoption,
    );
  }
}
