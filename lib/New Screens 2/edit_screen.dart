import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/models/pets.dart';
import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as i;
import 'package:flutter/material.dart';
import 'package:cns/models/new_user_model.dart';
import 'package:cns/util/color.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditScreen extends StatefulWidget {
  final PetModel pet;
  final imageList;

  const EditScreen({required Key key, required this.pet, required this.imageList}) : super(key: key);
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _imageUrls = widget.imageList;
    // print(showMe);
    // currentlocation();
    // ageRange = RangeValues(double.parse("50.00"), (double.parse("100.00")));
    // aboutCtlr.text = widget.currentUser.editInfo['about'];
    // companyCtlr.text = widget.currentUser.editInfo['company'];
    // livingCtlr.text = widget.currentUser.editInfo['living_in'];
    // universityCtlr.text = widget.currentUser.editInfo['university'];
    // jobCtlr.text = widget.currentUser.editInfo['job_title'];
    // setState(() {
    //   showMe = "man";
    //   visibleAge = widget.currentUser.editInfo['showMyAge'] ?? false;
    //   print(widget.currentUser.editInfo["WantToAdopt"]);
    //   visibleDistance = widget.currentUser.editInfo['DistanceVisible'] ?? true;
    // });
  }

  late List<String> _imageUrls;
  bool get isProfilePicture => _imageUrls.isEmpty;

  // void currentlocation() async {
  //   // var currentLocation = await getLocationCoordinates();
  //   // setState(() {
  //   //   livingCtlr.text = currentLocation["PlaceName"];
  //   // });
  // }
  //
  Future updateImages() async {
    print("Updating Images for ${widget.pet.id}");
    try{
      await FirebaseFirestore.instance.collection("PetAdoption").doc(widget.pet.id).set({
        'image': (_imageUrls),
      }, SetOptions(merge: true));
    } catch (e){
      print(e);
    }
  }

  Future source(
    BuildContext context,
    currentUser,
  ) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(isProfilePicture ? "Update profile picture" : "Add pictures"),
            content: Text(
              "Select source",
            ),
            insetAnimationCurve: Curves.decelerate,
            actions: currentUser.imageUrl.length < 9
                ? <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.photo_camera,
                              size: 28,
                            ),
                            Text(
                              " Camera",
                              style: TextStyle(fontSize: 15, color: Colors.black, decoration: TextDecoration.none),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) {
                                getImage(
                                  ImageSource.camera,
                                  context,
                                );
                                return Center(
                                    child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ));
                              });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.photo_library,
                              size: 28,
                            ),
                            Text(
                              " Gallery",
                              style: TextStyle(fontSize: 15, color: Colors.black, decoration: TextDecoration.none),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                getImage(
                                  ImageSource.gallery,
                                  context,
                                );
                                return Center(
                                    child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ));
                              });
                        },
                      ),
                    ),
                  ]
                : [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Center(
                          child: Column(
                        children: <Widget>[
                          Icon(Icons.error),
                          Text(
                            "Can't upload more than 9 pictures",
                            style: TextStyle(fontSize: 15, color: Colors.black, decoration: TextDecoration.none),
                          ),
                        ],
                      )),
                    )
                  ],
          );
        });
  }

  Future getImage(ImageSource imageSource, context,) async {
    PickedFile? image = await ImagePicker().getImage(source: imageSource);
    if (image != null) {
      File? croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          cropStyle: CropStyle.circle,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Crop',
              toolbarColor: primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (croppedFile != null) {
        await uploadFile(
          await compressImage(croppedFile)
        );
      }
    }
    Navigator.pop(context);
  }

  Future compressImage(File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    i.Image? imageFile = i.decodeImage(image.readAsBytesSync());
    final compressedImage = File('$path.jpg')..writeAsBytesSync(i.encodeJpg(imageFile!, quality: 80));
    // setState(() {
    return compressedImage;
    // });
  }

  Future uploadFile(
    File image,
  ) async {
    Reference storageReference = FirebaseStorage.instance.ref().child('Pets/${widget.pet.id}/${image.hashCode}.jpg');
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => storageReference.getDownloadURL().then((fileURL) async {
          try {
            _imageUrls.add(fileURL.toString());
          } catch (err) {
            print("Error: $err");
          }
        }));
  }

  int variableSet = 0;
  late ScrollController _scrollController;
  double width = 50;
  double height = 75;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Profile _profile = new Profile(widget.currentUser);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          title: Text(
            "Edit Profile Images",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Color(0xff0e289f)),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: DragAndDropGridView(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: MediaQuery.of(context).size.aspectRatio * 1.5,
                  ),
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      child: LayoutBuilder(
                        builder: (context, costrains) => GridTile(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: AspectRatio(
                              aspectRatio: MediaQuery.of(context).size.aspectRatio * 1.5,
                              child: Image.network(
                                _imageUrls[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _imageUrls.length,
                  onWillAccept: (oldIndex, newIndex) => !(oldIndex == newIndex),
                  onReorder: (oldIndex, newIndex) {
                    _imageUrls.insert(newIndex, _imageUrls.removeAt(oldIndex));
                    setState(() {});
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_imageUrls.length < 9)
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(8),
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () => source(context, widget.pet),
                    child: Text("Add Photos"),
                  ),
                if (_imageUrls.isNotEmpty)
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(8),
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await updateImages();
                      Navigator.pop(context);
                    },
                    child: Text("Save Changes"),
                  ),
              ],
            ),
            // Divider(),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ListBody(
            //     mainAxis: Axis.vertical,
            //     children: <Widget>[
            //       // ListTile(
            //       //   title: Text(
            //       //     "About ${widget.currentUser.name}",
            //       //     style: TextStyle(
            //       //         fontWeight: FontWeight.w500,
            //       //         fontSize: 16,
            //       //         color: Colors.black87),
            //       //   ),
            //       //   subtitle: CupertinoTextField(
            //       //     controller: aboutCtlr,
            //       //     cursorColor: primaryColor,
            //       //     maxLines: 10,
            //       //     minLines: 3,
            //       //     placeholder: "About your pet",
            //       //     padding: EdgeInsets.all(10),
            //       //     onChanged: (text) {
            //       //       editInfo.addAll({'about': text});
            //       //     },
            //       //   ),
            //       // ),
            //       Padding(
            //         padding: const EdgeInsets.all(0.1),
            //         child: Padding(
            //           padding: const EdgeInsets.all(0.1),
            //           // child: ListTile(
            //           //   title: Text(
            //           //     "Age range",
            //           //     style: TextStyle(
            //           //         fontSize: 18,
            //           //         color: primaryColor,
            //           //         fontWeight: FontWeight.w500),
            //           //   ),
            //           //   trailing: Text(
            //           //     "${ageRange.start.round()}-${ageRange.end.round()}",
            //           //     style: TextStyle(fontSize: 16),
            //           //   ),
            //           //   subtitle: RangeSlider(
            //           //       inactiveColor: secondryColor,
            //           //       values: ageRange,
            //           //       min: 18.0,
            //           //       max: 100.0,
            //           //       divisions: 25,
            //           //       activeColor: primaryColor,
            //           //       labels: RangeLabels(
            //           //           '${ageRange.start.round()}',
            //           //           '${ageRange.end.round()}'),
            //           //       onChanged: (val) {
            //           //         // changeValues.addAll({
            //           //         //   'age_range': {
            //           //         //     'min': '${val.start.truncate()}',
            //           //         //     'max': '${val.end.truncate()}'
            //           //         //   }
            //           //         // });
            //           //         setState(() {
            //           //           ageRange = val;
            //           //         });
            //           //       }),
            //           // ),
            //         ),
            //       ),
            //       // ListTile(
            //       //   title: Text(
            //       //     "Job title",
            //       //     style: TextStyle(
            //       //         fontWeight: FontWeight.w500,
            //       //         fontSize: 16,
            //       //         color: Colors.black87),
            //       //   ),
            //       //   subtitle: CupertinoTextField(
            //       //     controller: jobCtlr,
            //       //     cursorColor: primaryColor,
            //       //     placeholder: "Add job title",
            //       //     padding: EdgeInsets.all(10),
            //       //     onChanged: (text) {
            //       //       editInfo.addAll({'job_title': text});
            //       //     },
            //       //   ),
            //       // ),
            //       // ListTile(
            //       //   title: Text(
            //       //     "Company",
            //       //     style: TextStyle(
            //       //         fontWeight: FontWeight.w500,
            //       //         fontSize: 16,
            //       //         color: Colors.black87),
            //       //   ),
            //       //   subtitle: CupertinoTextField(
            //       //     controller: companyCtlr,
            //       //     cursorColor: primaryColor,
            //       //     placeholder: "Add company",
            //       //     padding: EdgeInsets.all(10),
            //       //     onChanged: (text) {
            //       //       editInfo.addAll({'company': text});
            //       //     },
            //       //   ),
            //       // ),
            //       // ListTile(
            //       //   title: Text(
            //       //     "University",
            //       //     style: TextStyle(
            //       //         fontWeight: FontWeight.w500,
            //       //         fontSize: 16,
            //       //         color: Colors.black87),
            //       //   ),
            //       //   subtitle: CupertinoTextField(
            //       //     controller: universityCtlr,
            //       //     cursorColor: primaryColor,
            //       //     placeholder: "Add university",
            //       //     padding: EdgeInsets.all(10),
            //       //     onChanged: (text) {
            //       //       editInfo.addAll({'university': text});
            //       //     },
            //       //   ),
            //       // ),
            //       ListTile(
            //         title: Text(
            //           "Current Location",
            //           style: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               fontSize: 16,
            //               color: Colors.black87),
            //         ),
            //         trailing: Icon(
            //           Icons.location_on,
            //           size: 35,
            //         ),
            //         // onTap: () async {
            //         //   var address = await Navigator.push(
            //         //       context,
            //         //       MaterialPageRoute(
            //         //           builder: (context) => UpdateLocation()));
            //         //   print(address);
            //         //   if (address != null) {
            //         //     _updateAddress(address);
            //         //   }
            //         // },
            //         subtitle: CupertinoTextField(
            //           controller: livingCtlr,
            //           cursorColor: primaryColor,
            //           placeholder: "Add city",
            //           padding: EdgeInsets.all(10),
            //           onChanged: (text) {
            //             editInfo.addAll({'living_in': text});
            //           },
            //         ),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       ListTile(
            //           title: Text(
            //             "Control your profile",
            //             style: TextStyle(
            //                 fontWeight: FontWeight.w500,
            //                 fontSize: 16,
            //                 color: Colors.black87),
            //           ),
            //           subtitle: Card(
            //             child: Column(
            //               mainAxisAlignment:
            //                   MainAxisAlignment.spaceAround,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: <Widget>[
            //                 // Row(
            //                 //   mainAxisAlignment:
            //                 //       MainAxisAlignment.spaceBetween,
            //                 //   children: <Widget>[
            //                 //     Padding(
            //                 //       padding: const EdgeInsets.all(8.0),
            //                 //       child: Text("Don't Show My Age"),
            //                 //     ),
            //                 //     Switch(
            //                 //         activeColor: primaryColor,
            //                 //         value: visibleAge,
            //                 //         onChanged: (value) {
            //                 //           editInfo
            //                 //               .addAll({'showMyAge': value});
            //                 //           setState(() {
            //                 //             visibleAge = value;
            //                 //           });
            //                 //         })
            //                 //   ],
            //                 // ),
            //                 Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: <Widget>[
            //                     Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: Text("Make My Distance Visible"),
            //                     ),
            //                     Switch(
            //                         activeColor: primaryColor,
            //                         value: visibleDistance,
            //                         onChanged: (value) {
            //                           editInfo.addAll(
            //                               {'DistanceVisible': value});
            //                           setState(() {
            //                             visibleDistance = value;
            //                           });
            //                         })
            //                   ],
            //                 ),
            //                 // Row(
            //                 //   mainAxisAlignment:
            //                 //       MainAxisAlignment.spaceBetween,
            //                 //   children: <Widget>[
            //                 //     Padding(
            //                 //       padding: const EdgeInsets.all(8.0),
            //                 //       child: Text(
            //                 //           "Want your pet to register for adoption"),
            //                 //     ),
            //                 //     Switch(
            //                 //         activeColor: primaryColor,
            //                 //         value: visibleDistance,
            //                 //         onChanged: (value) {
            //                 //           editInfo.addAll(
            //                 //               {'DistanceVisible': value});
            //                 //           setState(() {
            //                 //             visibleDistance = value;
            //                 //           });
            //                 //         })
            //                 //   ],
            //                 // ),
            //               ],
            //             ),
            //           )),
            //       SizedBox(
            //         height: 100,
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
