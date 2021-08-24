import 'package:flutter/material.dart';

class petAdoptionNgoSelect extends StatefulWidget {
  petAdoptionNgoSelect({Key? key}) : super(key: key);

  @override
  _petAdoptionNgoSelectState createState() => _petAdoptionNgoSelectState();
}

class _petAdoptionNgoSelectState extends State<petAdoptionNgoSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Ngo"),
      ),
    );
  }
}
