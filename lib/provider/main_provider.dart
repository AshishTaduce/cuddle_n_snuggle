import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cns/models/custom_web_view.dart';
import 'package:cns/models/new_user_model.dart';
import 'package:cns/models/petadoption.dart';
import 'package:cns/models/pets.dart';

class MainProvider extends ChangeNotifier {
  NewUser? currentUser;

  List<PetsModel> myPets = [];
  List<PetsAdoption> myPetAdoptions = [];

  List<PetsModel> petMatches = [];
  List<PetsModel> matchesByGender = [];
  List<PetsAdoption> matchedPetAdoption = [];

  ValueNotifier<List<DocumentSnapshot>> petNotifier = ValueNotifier<List<DocumentSnapshot>>([]);

  late List<String> petCategory;
  late List<String> petSubCategory;

  static const your_client_id = '859647244877727';
  static const your_redirect_url = 'https://cnsi-b4f1c.firebaseapp.com/__/auth/handler';

  Future setDataUser(User user, String isIndividual, String name) async {
    print("------- Set data User Name ----------");
    print(name);
    await FirebaseFirestore.instance.collection("Users").doc(user.uid).set(
        {
          'userId': user.uid,
          'isIndiviual': isIndividual,
          'userName': name,
          'phoneNumber': user.phoneNumber,
          'timestamp': FieldValue.serverTimestamp(),
          'Pets': FieldValue.arrayUnion([]),
          'Pictures': FieldValue.arrayUnion([
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxUC64VZctJ0un9UBnbUKtj-blhw02PeDEQIMOqovc215LWYKu&s"
          ])
        },
        SetOptions(
          merge: true,
        ));
  }

  Future<dynamic> handleGoogleSign(BuildContext context, String isIndiviual) async {
    User _user;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await _auth.signInWithCredential(credential);
    _user = authResult.user!;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    User currentUser = _auth.currentUser!;
    assert(_user.uid == currentUser.uid);
    print("User Name NEW INDividual: ${_user.displayName}");
    print("User Email NEW Individual: ${_user.email}");
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: authResult.user!.uid)
          .get()
          .then((QuerySnapshot snapshot) async {
        if (snapshot.docs.length <= 0) {
          await setDataUser(authResult.user!, isIndiviual, authResult.user!.displayName!);
        }
        await loadUserDetails();
      });
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> handleGoogleSignNGO(
    BuildContext context,
    String isNGO,
  ) async {
    User _user;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await _auth.signInWithCredential(credential);
    _user = authResult.user!;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    User? currentUser = _auth.currentUser;
    assert(_user.uid == currentUser!.uid);
    print("User Name NGO: ${_user.displayName}");
    print("User Email NGO:  ${_user.email}");
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: authResult.user!.uid)
          .get()
          .then((QuerySnapshot snapshot) async {
        if (snapshot.docs.length <= 0) {
          await setDataUser(authResult.user!, isNGO, authResult.user!.displayName!);
        }
        await loadUserDetails();
      });
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> handleFacebookLogin(context) async {
    User user;
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomWebView(
          selectedUrl:
              'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
        ),
        maintainState: true,
      ),
    );
    try {
      final facebookAuthCred = FacebookAuthProvider.credential(result);
      user = (await FirebaseAuth.instance.signInWithCredential(facebookAuthCred)).user!;
      print('user $user');
      return "Success";
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> loadUserDetails() async {
    User user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: user.uid)
        .get()
        .then((QuerySnapshot snapshot) async {
      currentUser = NewUser.fromDocument(snapshot.docs[0]);
      notifyListeners();
      getPets();
      getAdoptionPets();
      return currentUser;
    });
  }

  Future<dynamic> decideSplash() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? authResult = _auth.currentUser;
    if (authResult == null) {
      print("NotVerified");
    } else {
      await loadUserDetails();
      await getPets();
      await getAdoptionPets();
    }
  }

  ///Pet handling below.

  Future<dynamic> updateMatches(String cate, String sex, String subcat) async {
    await FirebaseFirestore.instance
        .collection('Pets')
        .where('category', isEqualTo: cate)
        .where('subcategory', isEqualTo: subcat)
        .where('sex', isEqualTo: sex.contains("fe") ? "Male" : "Female")
        .get()
        .then((data) {
      List<PetsModel> orders = <PetsModel>[];
      int totalCount = data.docs.length;
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < totalCount; i++) {
          print(data.docs[i]["subcategory"]);
          orders.add(PetsModel.fromDocument(data.docs[i], data.docs[i].data()));
        }
        petMatches = orders;
        notifyListeners();
        // print(pet_match[0].category.toString());
      } else {
        print("No data for pet match");
      }
    });
  }

  Future<dynamic> updateMatchesByGender(String cate, String sex, String subcat) async {
    await FirebaseFirestore.instance
        .collection('Pets')
        .where('category', isEqualTo: cate)
        .where('subcategory', isEqualTo: subcat)
        .where('sex', isEqualTo: sex.contains("fe") ? "Male" : "Female")
        .get()
        .then((data) {
      List<PetsModel> orders = <PetsModel>[];
      if (data.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in data.docs) {
          orders.add(PetsModel.fromDocument(doc, doc.data()));
        }
        orders.removeWhere((element) => element.userId == currentUser!.id);
        matchesByGender = orders;
      } else {
        debugPrint("No Data Found for Matching gender");
      }
      notifyListeners();
    });
  }

  Future<dynamic> updatePetMatches(String _category, String sex, String _subCategory) async {
    await FirebaseFirestore.instance.collection('PetAdoption').get().then((data) {
      List<PetsAdoption> orders = <PetsAdoption>[];
      int totalCount = data.docs.length;
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < totalCount; i++) {
          orders.add(PetsAdoption.fromDocument(data.docs[i], data.docs[i].data()));
          orders = orders.where((element) => element.userId != currentUser!.id).toList();
          matchedPetAdoption = orders;
        }
      } else {
        print("No Pet Adoption");
      }
      notifyListeners();
    });
  }

  Future<dynamic> addPet(String name, String dob, String category, File image, String subcategory, String bio,
      bool vaccinated, bool kssi, String sex, bool isAdoption) async {
    try {
      String _uploadedFileURL = "";
      Reference storageReference = FirebaseStorage.instance.ref().child("Pets/${image.hashCode}.jpg");
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(
        () => storageReference.getDownloadURL().then(
          (fileURL) {
            _uploadedFileURL = fileURL;
          },
        ),
      );
      FirebaseFirestore.instance.collection(isAdoption ? "PetAdoption" : "Pets").doc().set(
        {
          "name": name.toString(),
          "petdob": dob.toString(),
          "category": category.toString(),
          "image": FieldValue.arrayUnion([
            _uploadedFileURL,
          ]),
          "subcategory": subcategory.toString(),
          "bio": bio.toString(),
          "vaccinated": vaccinated.toString(),
          "kssi_certified": kssi.toString(),
          "userId": currentUser!.id.toString(),
          "userName": currentUser!.name.toString(),
          "sex": sex.toString()
        },
      );
      isAdoption ? getAdoptionPets() : getPets();
      return "Success";
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getPets() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance.collection('Pets').where('userId', isEqualTo: user.uid).get().then((data) {
        List<PetsModel> orders = <PetsModel>[];
        List<String> _categories = [];
        List<String> _subCategories = [];

        if (data.docs.isEmpty) {
          myPets = [];
          _categories = [];
          _subCategories = [];
        } else {
          for (int i = 0; i < data.docs.length; i++) {
            orders.add(PetsModel.fromDocument(data.docs[i], data.docs[i].data()));
            _categories.add(data.docs[i]["category"]);
            _subCategories.add(data.docs[i]["subcategory"]);
          }
          petCategory = _categories;
          petSubCategory = _subCategories;
          myPets = orders;
          for (int i = 0; i < _categories.length; i++) {
            updateMatches(
              myPets[i].category.toString(),
              myPets[i].sex.toString() == "Male" ? "Female" : "Male",
              myPets[i].subcategory.toString(),
            );
          }
        }
        notifyListeners();
      });
    } catch (e) {
      debugPrint("------- Error from pet adoption ---------");
      throw e;
    }
  }

  Future<dynamic> getAdoptionPets() async {
    await FirebaseFirestore.instance.collection('PetAdoption').get().then((data) {
      matchedPetAdoption = [];
      petCategory = [];
      petSubCategory = [];

      if (data.docs.isNotEmpty) {
        for (int i = 0; i < data.docs.length; i++) {
          matchedPetAdoption.add(PetsAdoption.fromDocument(data.docs[i], data.docs[i].data()));
          petCategory.add(data.docs[i]["category"]);
          petSubCategory.add(data.docs[i]["subcategory"]);
        }

        myPetAdoptions = matchedPetAdoption.where((element) => element.userId == currentUser!.id).toList();
        matchedPetAdoption = matchedPetAdoption.where((element) => element.userId != currentUser!.id).toList();

        for (int i = 0; i < myPetAdoptions.length; i++) {
          updatePetMatches(
            myPetAdoptions[i].category.toString(),
            myPetAdoptions[i].sex.toString() == "Male" ? "Female" : "Male",
            myPetAdoptions[i].subcategory.toString(),
          );
        }

        notifyListeners();
      }
    });
  }
}
