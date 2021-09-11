import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/models/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cns/models/custom_web_view.dart';
import 'package:cns/models/new_user_model.dart';
import 'package:cns/models/pets.dart';

class MainProvider extends ChangeNotifier {
  NewUser? currentUser;
  List<PetModel> myPets = [];
  List<PetModel> myPetAdoptions = [];
  List<NewUser> ngoUsers = <NewUser>[];
  List<PetModel> petMatches = [];
  List<PetModel> matchesByGender = [];
  List<PetModel> matchedPetAdoption = [];
  List<PetModel> favouritePets = [];
  List<EventModel> upcomingEvents = [];

  ValueNotifier<List<DocumentSnapshot>> petNotifier =
      ValueNotifier<List<DocumentSnapshot>>([]);

  late List<String> petCategory;
  late List<String> petSubCategory;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static const your_client_id = '859647244877727';
  static const your_redirect_url =
      'https://cnsi-b4f1c.firebaseapp.com/__/auth/handler';

  Future setDataUser(User user, String isIndividual, String name) async {
    await FirebaseFirestore.instance.collection("Users").doc(user.uid).set(
      {
        'userId': user.uid,
        'isIndiviual': isIndividual,
        'userName': name,
        'emailaddress': "",
        'phoneNumber': user.phoneNumber,
        'timestamp': FieldValue.serverTimestamp(),
        'ngoaddress': "",
        'ngotype': "",
        'estyear': "",
        'ngotiming': "",
        'Pictures': FieldValue.arrayUnion([
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxUC64VZctJ0un9UBnbUKtj-blhw02PeDEQIMOqovc215LWYKu&s"
        ])
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<dynamic> ngoSignUp(Map signupData) async {
    late User _user;

    try {
      UserCredential authResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: signupData["email"],
        password: signupData["password"],
      );
      _user = authResult.user!;
      await FirebaseFirestore.instance.collection("Users").doc(_user.uid).set({
        'userid': _user.uid,
        'emailaddress': signupData["email"],
        'userName': signupData["userName"],
        'ngoaddress': signupData["ngoaddress"],
        'ngotype': signupData["ngotype"],
        'timestamp': FieldValue.serverTimestamp(),
        'estyear': signupData["estyear"],
        'ngotiming': signupData["ngotiming"],
        'phoneNumber': signupData["mobilenumber"],
        'isIndiviual': "false",
        'Pictures': FieldValue.arrayUnion([
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxUC64VZctJ0un9UBnbUKtj-blhw02PeDEQIMOqovc215LWYKu&s"
        ])
      });
      currentUser = NewUser(
          id: _user.uid,
          name: signupData["ngoname"],
          imageUrl:
              "https://images.unsplash.com/photo-1600077029182-92ac8906f9a3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60",
          ngoaddress: signupData["ngoaddress"],
          ngotype: signupData["ngotype"],
          ngotiming: signupData["ngotiming"],
          time: FieldValue.serverTimestamp(),
          estyear: signupData["estyear"],
          emailaddress: signupData["emailaddress"],
          isIndiviual: "false",
          phoneNumber: signupData["mobilenumber"]);
      //TODO: parameter pass???
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // return e.message;
      throw e;
    }
  }

  Future<dynamic> handleGoogleSign(
      BuildContext context, String isIndividual) async {
    User _user;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
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

    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: authResult.user!.uid)
          .get()
          .then((QuerySnapshot snapshot) async {
        if (snapshot.docs.length <= 0) {
          await setDataUser(
              authResult.user!, isIndividual, authResult.user!.displayName!);
        }
        await loadUserDetails();
      });
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> updateNGOList() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .where('isIndiviual', isNotEqualTo: "Indiviual")
        .get()
        .then(
          (data) => ngoUsers = data.docs
              .map(
                (doc) => NewUser.fromDocument(doc),
              )
              .toList(),
        );
    notifyListeners();
  }

  // Future<dynamic> handleGoogleSignNGO(
  //   BuildContext context,
  //   String isNGO,
  // ) async {
  //   User _user;
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   final GoogleSignIn _googleSignIn = GoogleSignIn();
  //   GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //   GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount!.authentication;
  //   AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //   UserCredential authResult = await _auth.signInWithCredential(credential);
  //   _user = authResult.user!;
  //   assert(!_user.isAnonymous);
  //   assert(await _user.getIdToken() != null);
  //   User? currentUser = _auth.currentUser;
  //   assert(_user.uid == currentUser!.uid);
  //   print("User Name NGO: ${_user.displayName}");
  //   print("User Email NGO:  ${_user.email}");
  //   if (currentUser != null) {
  //     FirebaseFirestore.instance
  //         .collection('Users')
  //         .where('userId', isEqualTo: authResult.user!.uid)
  //         .get()
  //         .then((QuerySnapshot snapshot) async {
  //       if (snapshot.docs.length <= 0) {
  //         await setDataUser(
  //             authResult.user!, isNGO, authResult.user!.displayName!);
  //       }
  //       await loadUserDetails();
  //     });
  //     return "Success";
  //   } else {
  //     return "Failed";
  //   }
  // }

  void fetchVaccinations() async {
    DocumentSnapshot vaccinationsList = await FirebaseFirestore.instance
        .collection('Reminders')
        .doc(currentUser!.id.toString())
        .get();
    print("VACCINEEEEEEEEEEEEEE%%%%%%%");
    print(vaccinationsList);
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
      user =
          (await FirebaseAuth.instance.signInWithCredential(facebookAuthCred))
              .user!;
      print('user $user');
      return "Success";
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> loadUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: user!.uid)
        .get()
        .then((QuerySnapshot snapshot) async {
      currentUser = NewUser.fromDocument(snapshot.docs[0]);
      notifyListeners();
      getPets();
      print("VACCINE");
      fetchVaccinations();

      getAdoptionPets();

      updateNGOList();
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

  Future<dynamic> updateMatches(String cate, String sex, String subcat) async {
    await FirebaseFirestore.instance
        .collection('Pets')
        .where('category', isEqualTo: cate)
        .where('subcategory', isEqualTo: subcat)
        .where('sex', isEqualTo: sex.contains("fe") ? "Male" : "Female")
        .get()
        .then((data) {
      List<PetModel> orders = <PetModel>[];
      int totalCount = data.docs.length;
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < totalCount; i++) {
          print(data.docs[i]["subcategory"]);
          orders.add(
              PetModel.fromDocument(data.docs[i], data.docs[i].data(), false));
        }
        matchesByGender = orders;
        notifyListeners();
        // print(pet_match[0].category.toString());
      } else {
        print("No data for pet match");
      }
    });
  }

  Future<dynamic> updateMatchesByGender(
      String category, String sex, String subCategory) async {
    await FirebaseFirestore.instance
        .collection('Pets')
        .where('category', isEqualTo: category)
        .where('subcategory', isEqualTo: subCategory)
        .where('sex', isEqualTo: sex.contains("fe") ? "Male" : "Female")
        .get()
        .then((data) {
      List<PetModel> orders = <PetModel>[];
      if (data.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in data.docs) {
          orders.add(PetModel.fromDocument(doc, doc.data(), false));
        }
        orders.removeWhere((element) => element.userId == currentUser!.id);
        matchesByGender = orders;
      } else {
        debugPrint("No Data Found for Matching gender");
      }
      notifyListeners();
    });
  }

  Future<dynamic> updatePetMatches(
      String _category, String sex, String _subCategory) async {
    await FirebaseFirestore.instance
        .collection('PetAdoption')
        .get()
        .then((data) {
      List<PetModel> orders = <PetModel>[];
      int totalCount = data.docs.length;
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < totalCount; i++) {
          orders.add(
              PetModel.fromDocument(data.docs[i], data.docs[i].data(), true));
          orders = orders
              .where((element) => element.userId != currentUser!.id)
              .toList();
          matchedPetAdoption = orders;
        }
      } else {
        print("No Pet Adoption");
      }
      notifyListeners();
    });
  }

  Future<dynamic> addPet(
      String name,
      String dob,
      String category,
      File image,
      String subcategory,
      String bio,
      bool vaccinated,
      bool kssi,
      String sex,
      bool isAdoption) async {
    try {
      String _uploadedFileURL = "";
      Reference storageReference =
          FirebaseStorage.instance.ref().child("Pets/${image.hashCode}.jpg");
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(
        () => storageReference.getDownloadURL().then(
          (fileURL) {
            _uploadedFileURL = fileURL;
          },
        ),
      );
      FirebaseFirestore.instance
          .collection(isAdoption ? "PetAdoption" : "Pets")
          .doc()
          .set(
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
      print(e);
      throw e;
    }
  }

  Future<dynamic> getPets() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('Pets')
          .where('userId', isEqualTo: user.uid)
          .get()
          .then((data) {
        List<PetModel> orders = <PetModel>[];
        List<String> _categories = [];
        List<String> _subCategories = [];

        if (data.docs.isEmpty) {
          myPets = [];
          _categories = [];
          _subCategories = [];
        } else {
          for (int i = 0; i < data.docs.length; i++) {
            orders.add(
              PetModel.fromDocument(data.docs[i], data.docs[i].data(), false),
            );
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
    await FirebaseFirestore.instance
        .collection('PetAdoption')
        .get()
        .then((data) {
      matchedPetAdoption = [];
      petCategory = [];
      petSubCategory = [];

      if (data.docs.isNotEmpty) {
        for (int i = 0; i < data.docs.length; i++) {
          matchedPetAdoption.add(
              PetModel.fromDocument(data.docs[i], data.docs[i].data(), true));
          petCategory.add(data.docs[i]["category"]);
          petSubCategory.add(data.docs[i]["subcategory"]);
        }

        myPetAdoptions = matchedPetAdoption
            .where((element) => element.userId == currentUser!.id)
            .toList();
        matchedPetAdoption = matchedPetAdoption
            .where((element) => element.userId != currentUser!.id)
            .toList();

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

  void updateValues() {
    notifyListeners();
  }
}
