import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tindaa/controllers/global.dart';
import 'package:tindaa/controllers/profile_controler.dart';
import 'package:tindaa/tabScreens/user_details_screen.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen({super.key});

  @override
  State<SwippingScreen> createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen> {
  ProfileControler profileControler = Get.put(ProfileControler());
  String senderName = "";
  readCurrentUserData() async{
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .get().then((dataSnapshot){
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCurrentUserData();
  }
  bool fillStar = false;
  bool fillHeart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx((){
          return PageView.builder(
            itemCount: profileControler.allUsersProfileList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              var eachProfileInfo = profileControler.allUsersProfileList[index];

              return DecoratedBox(
                   decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            eachProfileInfo.imageProfile.toString(),
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                    // filter icon button
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: IconButton(
                            onPressed: (){

                            },
                            icon: const Icon(
                                Icons.filter_list,
                                size: 30,
                              color: Colors.black,
                            ),

                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          profileControler
                              .ViewSentAndViewRecieved(eachProfileInfo.uid.toString(),
                            senderName,);

                          Get.to(UserDetailsScreen(userId: eachProfileInfo.uid.toString()));
                        },
                        child: Column(
                          children: [
                            // name
                            Text(
                              eachProfileInfo.name.toString(),
                              style: const TextStyle(
                                color: Colors.purpleAccent,
                                fontSize: 24,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // age - city
                            Text(
                              eachProfileInfo.age.toString() + "." + eachProfileInfo.city.toString() ,
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 14,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // User data
                      GestureDetector(
                        onTap: (){

                        },
                        child: Column(
                          children: [


                            const SizedBox(
                              height: 4,
                            ),
// profession & religion
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                ElevatedButton(
                                onPressed:(){},
                                    style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)
                                  ),
                                      backgroundColor: Colors.deepPurple,
                                ),
                                    child: Text(
                                      eachProfileInfo.profession.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                ElevatedButton(
                                    onPressed:(){},
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                      backgroundColor: Colors.deepPurple,
                                    ),
                                    child: Text(
                                      eachProfileInfo.religion.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                ),
                              ],
                            ),

                            // country and ethnicity
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                ElevatedButton(
                                    onPressed:(){},
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                      backgroundColor: Colors.deepPurple,
                                    ),
                                    child: Text(
                                      eachProfileInfo.country.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                ElevatedButton(
                                    onPressed:(){},
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                        backgroundColor: Colors.deepPurple,
                                    ),
                                    child: Text(
                                      eachProfileInfo.ethnicity.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      // buttons , fav, like, save
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //favorite button
                          GestureDetector(
                            onTap: (){

                            },
                            child: IconButton(
                              color: Colors.purpleAccent, onPressed: () {
                              profileControler.favoriteSentAndFavoriteRecieved(
                                eachProfileInfo.uid.toString(),
                                senderName,
                              );


                              setState(() {
                                  fillStar = !fillStar;
                                });

                            },
                              iconSize: 45,
                                icon: Icon(
                                  fillStar?Icons.star_outlined
                                      : Icons.star_border_outlined,

                                ),



                            ),

                          ),
                          // like
                          GestureDetector(
                            onTap: (){

                            },
                            child: const Icon(
                              Icons.chat_rounded,
                              size: 55,
                              color: Colors.purpleAccent,
                            )
                          ),
                          //chat
                          GestureDetector(
                            onTap: (){

                            },
                            child: IconButton(
                              color: Colors.purpleAccent, onPressed: () {
                              profileControler.LikeSentAndLikeRecieved(
                                eachProfileInfo.uid.toString(),
                                senderName,
                              );
                              setState(() {
                                fillHeart = !fillHeart;
                              });

                            },
                              iconSize: 45,
                              icon: Icon(
                                fillHeart?Icons.favorite_outlined
                                    : Icons.favorite_border_outlined,

                              ),



                            ),

                          ),
                        ],
                      ),


                    ],
                  ),
                ),
              );
            },
          );
        })
    );
  }
}
