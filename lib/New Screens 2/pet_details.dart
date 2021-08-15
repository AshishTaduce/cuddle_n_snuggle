import 'package:cns/New%20Screens%202/userDetails.dart';
import 'package:cns/models/pets.dart';
import 'package:flutter/material.dart';

class PetDetails extends StatefulWidget {
  final PetModel petInfo;
  const PetDetails({Key? key, required this.petInfo}) : super(key: key);

  @override
  _PetDetailsState createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  late PetModel petInfo;
  @override
  void initState() {
    petInfo = widget.petInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet Details"),
      ),
      bottomNavigationBar: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserDetails(userId: petInfo.userId,),
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(36),
          height: 54,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              "Visit Owner",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 32,
            ),
            CircleAvatar(
              radius: 72,
              backgroundImage: NetworkImage(petInfo.imageUrl[0], scale: 2.0),
            ),
            SizedBox(
              height: 48,
            ),
            Text(
              petInfo.petName,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              petInfo.category + " | " + petInfo.sex,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              petInfo.about,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
