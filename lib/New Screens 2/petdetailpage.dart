import 'package:cns/New%20Screens%202/petownerpage.dart';
import 'package:flutter/material.dart';

class PetDetailPage extends StatefulWidget {
  PetDetailPage({Key? key}) : super(key: key);

  @override
  _PetDetailPageState createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Me",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                // all the image of pet should be shown in carousel
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  "https://images.unsplash.com/photo-1586671267731-da2cf3ceeb80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80",
                  fit: BoxFit.cover,
                ),
              ),
              // check why  heart is not coming
              Positioned(
                  top: 300,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  )),
            ],
          ),
          Container(
            child: Text("Pet Name"),
          ),
          Container(
            child: Text("Pet Category"),
          ),
          Container(
            child: Text("Pet SubCategory"),
          ),
          Container(
            child: Text("Pet Date of Birth in Month and years"),
          ),
          Container(
            child: Text("Pet About Us"),
          ),
          Container(
            child: Text("Is Vaccinated - true / false"),
          ),
          Container(
            child: Text("Is KCI ceetified - true/false"),
          ),
          Container(
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PetOwnerPage()));
              },
              child: Text(
                  "Pet Owner Name Show and select on tap that should redirect like this"),
            ),
          ),
        ],
      ),
    );
  }
}
