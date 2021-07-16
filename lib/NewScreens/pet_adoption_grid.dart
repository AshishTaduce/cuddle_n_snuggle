import 'package:flutter/material.dart';
import 'package:hookup4u2/NewScreens/static_chat.dart';

class PetAdoptionGrid extends StatefulWidget {
  @override
  _PetAdoptionGridState createState() => _PetAdoptionGridState();
}

class _PetAdoptionGridState extends State<PetAdoptionGrid> {
  final List petInfo = [
    {
      'image':
          "http://cdn.akc.org/content/article-body-image/samoyed_puppy_dog_pictures.jpg",
      'dogname': "Scrubby",
      'petType': 'Dog',
      'petAge': '4',
      'ownerName': 'Animesh',
      'Sex': 'Male',
      'Breed': 'Pomerian',
      'Location': '200'
    },
    {
      'image': "https://i.ytimg.com/vi/MPV2METPeJU/maxresdefault.jpg",
      'dogname': "Niky",
      'petType': 'Dog',
      'petAge': '5',
      'ownerName': 'Pet NGO',
      'Sex': 'Male',
      'Breed': 'Labrador',
      'Location': '300'
    },
    {
      'image':
          "http://cdn.akc.org/content/article-body-image/samoyed_puppy_dog_pictures.jpg",
      'dogname': "Stacy",
      'petType': 'Dog',
      'petAge': '1',
      'ownerName': 'Save Street Pet NGO',
      'Sex': 'Female',
      'Breed': 'Persian Cat',
      'Location': '177'
    },
    {
      'image':
          "https://ichef.bbci.co.uk/news/1024/cpsprodpb/151AB/production/_111434468_gettyimages-1143489763.jpg",
      'dogname': "Scrubby",
      'petType': 'Dog',
      'petAge': '1',
      'ownerName': 'Manya',
      'Sex': 'Female',
      'Breed': 'Persian Cat',
      'Location': '100'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet Adoption"),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: petInfo.map((item) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 105,
                      width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          item["image"].toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["dogname"].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            item["Breed"].toString(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  Text(
                                    item["Location"].toString() + "KM",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StaticChat()));
                                      },
                                      child: Icon(Icons.message)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}
