import 'package:flutter/material.dart';
import 'package:cns/New%20Screens%202/chat.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:provider/provider.dart';

class PetAdoption extends StatefulWidget {
  @override
  _PetAdoptionState createState() => _PetAdoptionState();
}

class _PetAdoptionState extends State<PetAdoption> {
  bool exceedSwipes = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GradientAppBar("Pet Adoption"),
                Consumer<MainProvider>(
                  builder: (_, currentUser, __) {
                    return Container(
                      height: MediaQuery.of(context).size.height/2 * 200,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8,
                            crossAxisCount: 2),
                        // separatorBuilder: (context, index) {
                        //   return SizedBox(
                        //     height: 10,
                        //   );
                        // },
                        itemCount: currentUser.matchedPetAdoption.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [

                                    // CircleAvatar(
                                    //   radius: 50,
                                    //   backgroundImage: NetworkImage(
                                    //     currentUser
                                    //         .matchedPetAdoption[index]
                                    //         .imageUrl[0]
                                    //         .toString(),
                                    //   ),
                                    // ),

                                    Container(
                                      height: 230,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          alignment: Alignment.centerLeft,
                                          fit: BoxFit.cover, //I assumed you want to occupy the entire space of the card
                                          image: NetworkImage(
                                            // petInfo.imageUrl[0],
                                              currentUser
                                                    .matchedPetAdoption[index]
                                                    .imageUrl[0]
                                                    .toString(),
                                             // "https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=639&q=80"
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(

                                                child: Text(
                                                  currentUser
                                                      .matchedPetAdoption[index]
                                                      .petName
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .merge(TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                alignment: Alignment.bottomLeft,
                                                margin: EdgeInsets.only(bottom: 15.0,left: 5.0),
                                              ),

                                              Container(
                                                alignment: Alignment.bottomLeft,
                                                margin: EdgeInsets.only(bottom: 13.0,right: 5.0,),
                                                child: Consumer<MainProvider>(
                                                  builder: (_, account, __) {
                                                    return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ChatPage(
                                                                      currentUser:
                                                                      account.currentUser!,
                                                                      matchedPet: account
                                                                          .matchedPetAdoption[
                                                                      index],
                                                                      chatId: chatId(
                                                                        account.currentUser!.id,
                                                                        account
                                                                            .matchedPetAdoption[
                                                                        index]
                                                                            .userId,
                                                                      ),
                                                                    ),
                                                              ));
                                                        },
                                                        child:
                                                        Icon(Icons.messenger_outline,color: Colors.white,));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Container(
                                          //   height: 20,
                                          //   color: Colors.red,
                                          // )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
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
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 15,
            ),
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.merge(
                      TextStyle(
                        fontSize: 20,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // begin: Alignment.topRight,
          // end: Alignment.bottomLeft,
          colors: [

            Color(0xffff9827),
            Color(0xfffcc281),

        //     Colors.white,
        //     Colors.white
          ],
        ),
      ),
    );
  }
}

var groupChatId;
chatId(currentUser, sender) {
  if (currentUser.hashCode != sender.hashCode) {
    return groupChatId = '$currentUser-$sender';
  } else {
    return groupChatId = '$sender-$currentUser';
    // return groupChatId = '$sender';
  }
}
