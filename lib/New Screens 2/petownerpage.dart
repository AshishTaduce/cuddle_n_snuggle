import 'package:flutter/material.dart';

class PetOwnerPage extends StatefulWidget {
  PetOwnerPage({Key? key}) : super(key: key);

  @override
  _PetOwnerPageState createState() => _PetOwnerPageState();
}

class _PetOwnerPageState extends State<PetOwnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Owner Name"),
      ),
      body: Column(
        children: [
          Text(
              "Pet Owner Pic if he has / The first two letters as shown in profile page"),
          Text("Pet Owner Name"),
          Text("Pet Owner Pets for Pet Match"),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                // all the image of pet should be shown in carousel
                height: 250,
                width: 120,
                child: Image.network(
                  "https://images.unsplash.com/photo-1586671267731-da2cf3ceeb80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                // all the image of pet should be shown in carousel
                height: 250,
                width: 120,
                child: Image.network(
                  "https://images.unsplash.com/photo-1586671267731-da2cf3ceeb80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text("Pet Owner Pet for Adoption"),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                // all the image of pet should be shown in carousel
                height: 250,
                width: 120,
                child: Image.network(
                  "https://images.unsplash.com/photo-1586671267731-da2cf3ceeb80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                // all the image of pet should be shown in carousel
                height: 250,
                width: 120,
                child: Image.network(
                  "https://images.unsplash.com/photo-1586671267731-da2cf3ceeb80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// on tap of any of the pets .. pet detail page should open
// dont worry about design i will do that aap bass data call kardo
// for image make it in grid of axis count 2
