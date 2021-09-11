import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cns/New%20Screens%202/profilen.dart';
import 'package:cns/util/color.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/New%20Screens%202/chat.dart';
import 'package:cns/New%20Screens%202/pet_adoption.dart';
import 'package:cns/models/new_user_model.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'Calenderx.dart';
import 'Welcome_homepage.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with TickerProviderStateMixin {
  TabController? _controller;
  List<Widget> list = [
    Tab(
        icon: SvgPicture.asset(
      "asset/mating.svg",
    )),
    Tab(
        icon: SvgPicture.asset(
      "asset/adoption.svg",
    )),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: list.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: 1,
      length: 2,

      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Color(0xffff9827),
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.calendar_today_outlined, title: 'Calendar'),
            TabItem(icon: Icons.message, title: 'Message'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          disableDefaultTabController: true,
          initialActiveIndex: 2, //optional, default as 0

          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewScreenSecondHomePage()));
            } else if (index == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CalenderPage()));
            } else if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessagePage()));
            } else if (index == 3) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            }
          },
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Message",
            style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: "MyFont"),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _controller,
            tabs: list,
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Container(
              key: Key("1"),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: ClipRRect(
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // GradientAppBar("Message"),

                      Expanded(
                        child: Consumer<MainProvider>(
                          builder: (_, acc, __) {
                            print(acc.matchesByGender);
                            return RecentChats(
                                acc.currentUser!, acc.matchesByGender);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              key: Key("2"),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: ClipRRect(
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // GradientAppBar("Message"),

                      Expanded(
                        child: Consumer<MainProvider>(
                          builder: (_, acc, __) {
                            print(acc.matchedPetAdoption);
                            return RecentChats(
                                acc.currentUser!, acc.matchedPetAdoption);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.merge(
                      TextStyle(
                        fontSize: 25,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xff01b4c9), Color(0xff01b4c9)],
        ),
      ),
    );
  }
}

class RecentChats extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  final NewUser currentUser;
  final List petslist;

  RecentChats(this.currentUser, this.petslist);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: ListView.builder(
        itemCount: petslist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatPage(
                  chatId: chatId(
                    currentUser.id,
                    petslist[index].userId,
                  ),
                  currentUser: currentUser,
                  matchedPet: petslist[index],
                ),
              ),
            ),
            child: StreamBuilder(
              stream: db
                  .collection("chats")
                  .doc(
                    chatId(
                      currentUser.id,
                      petslist[index].userId,
                    ),
                  )
                  .collection('messages')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    child: CupertinoActivityIndicator(),
                  );
                else if (snapshot.data.docs.length == 0) {
                  return Container();
                }
                // index.lastmsg = snapshot.data.docs[0]['time'];
                return Container(
                  margin: EdgeInsets.only(
                      top: 5.0, bottom: 5.0, right: 10.0, left: 8.0),
                  decoration: BoxDecoration(
                    color:
                        snapshot.data.docs[0]['sender_id'] != currentUser.id &&
                                !snapshot.data.docs[0]['isRead']
                            ? Colors.white.withOpacity(.1)
                            : Colors.white.withOpacity(.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1.0, top: 10.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xfffcc281),
                        radius: 40.0,
                        backgroundImage: NetworkImage(
                            "${petslist[0].imageUrl[0].toString()}"),
                      ),
                      title: Text(
                        petslist[index]
                            .petName
                            .toString(), // please check whether it should be 0 or index
                        style: TextStyle(
                          fontFamily: 'Arial',
                          letterSpacing: 1.4,
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data.docs[0]['image_url'].toString().length > 0
                            ? "Photo"
                            : snapshot.data.docs[0]['text'],
                        style: TextStyle(
                          color: Color(0xffff9827),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            snapshot.data.docs[0]["time"] != null
                                ? DateFormat.MMMd()
                                    .add_jm()
                                    .format(
                                        snapshot.data.docs[0]["time"].toDate())
                                    .toString()
                                : "",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          snapshot.data.docs[0]['sender_id'] !=
                                      currentUser.id &&
                                  !snapshot.data.docs[0]['isRead']
                              ? Container(
                                  width: 40.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'NEW',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Text(""),
                          snapshot.data.docs[0]['sender_id'] == currentUser.id
                              ? !snapshot.data.docs[0]['isRead']
                                  ? Icon(
                                      Icons.done,
                                      color: secondryColor,
                                      size: 15,
                                    )
                                  : Icon(
                                      Icons.done_all,
                                      color: primaryColor,
                                      size: 15,
                                    )
                              : Text("")
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
