import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/models/user_model.dart';
import 'package:cns/util/color.dart';


class Notifications extends StatefulWidget {
  final User currentUser;
  Notifications(this.currentUser);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final db = FirebaseFirestore.instance;
  late CollectionReference matchReference;

  @override
  void initState() {
    matchReference = db
        .collection("Users")
        .doc(widget.currentUser.id)
        .collection('Matches');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: "MyFont",
              fontWeight: FontWeight.bold,


            ),
          ),
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                    stream: matchReference
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                            child: Text(
                          "No Notification",
                          style: TextStyle(color: secondryColor, fontSize: 16),
                        ));
                      else if (snapshot.data!.docs.length == 0) {
                        return Center(
                            child: Text(
                          "No Notification",
                          style: TextStyle(color: secondryColor, fontSize: 16),
                        ));
                      }
                      return Expanded(
                        child: ListView(
                          children:( snapshot.data!.docs)
                              .map((doc) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: !(doc.data as Map)['isRead']
                                                ? primaryColor.withOpacity(.15)
                                                : secondryColor
                                                    .withOpacity(.15)),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(5),
                                          leading: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: secondryColor,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                25,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    (doc.data as Map)['pictureUrl'] ??
                                                        "",
                                                fit: BoxFit.cover,
                                                useOldImageOnUrlChange: true,
                                                placeholder: (context, url) =>
                                                    CupertinoActivityIndicator(
                                                  radius: 20,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  Icons.error,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                              "you are matched with ${(doc.data as Map)['userName'] ?? "__"}"),
                                          subtitle: Text(
                                              "${((doc.data as Map)['timestamp'].toDate())}"),
                                          trailing: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                !(doc.data as Map)['isRead']
                                                    ? Container(
                                                        width: 40.0,
                                                        height: 20.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'NEW',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
                                                    : Text(""),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            print((doc.data as Map)["Matches"]);
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white),
                                                  ));
                                                });
                                            // DocumentSnapshot userdoc = await db
                                            //     .collection("Users")
                                            //     .doc((doc.data as Map)["Matches"])
                                            //     .get();
                                          },
                                        )
                                        //  : Container()
                                        ),
                                  ))
                              .toList(),
                        ),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
