import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  final String userId;
  const UserDetails({Key? key, required this.userId}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  void fetchUserInfo (){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: true,
              snap: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
            ),
            ),
          ];
        },
        body: FutureBuilder(
         builder: (context, userInfo) {
           return Container(
             child: Center(
               child: CircularProgressIndicator(),
             ),
           );
         },
        ),
      ),
    );
  }
}
