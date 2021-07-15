import 'package:flutter/material.dart';
import 'package:hookup4u2/util/color.dart';

class PetAdoption extends StatefulWidget {
  @override
  _PetAdoptionState createState() => _PetAdoptionState();
}

class _PetAdoptionState extends State<PetAdoption> {
  dynamic dogphotos = [
    "http://cdn.akc.org/content/article-body-image/samoyed_puppy_dog_pictures.jpg",
    "https://media.nature.com/lw800/magazine-assets/d41586-020-01430-5/d41586-020-01430-5_17977552.jpg",
    "https://i.ytimg.com/vi/MPV2METPeJU/maxresdefault.jpg",
    "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2018/08/kitten-440379.jpg?h=c8d00152&itok=1fdekAh2",
    "https://ichef.bbci.co.uk/news/1024/cpsprodpb/151AB/production/_111434468_gettyimages-1143489763.jpg"
  ];
  dynamic dogName = ["Scrubby", "Stacy", "Niky", "Tommy", "Sterla"];
  dynamic petType = ["Dog", "Dog", "Dog", "Cat", "Cat"];
  dynamic petAge = ["4", "1", "2", "4", "5"];
  dynamic ownerName = ["Animesh", "Save Street Pet NGO", "Pet NGO", "Mohak", "Manya"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Adoption',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(15),
                  height: 100,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(dogphotos[index], scale: 1),
                        radius: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dogName[index]),
                          Text(petType[index]),
                          Text(petAge[index]),
                          Text(ownerName[index]),
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: 5,
            ),
          ),
        ),
      ),
    );
  }
}
