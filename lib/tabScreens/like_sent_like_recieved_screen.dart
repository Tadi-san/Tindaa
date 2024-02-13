import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tindaa/controllers/global.dart';

class LikeSentLikeRecievedScreen extends StatefulWidget {
  const LikeSentLikeRecievedScreen({super.key});

  @override
  State<LikeSentLikeRecievedScreen> createState() => _LikeSentLikeRecievedScreenState();
}

class _LikeSentLikeRecievedScreenState extends State<LikeSentLikeRecievedScreen> {

  bool isLikeSentClicked = true;
  List<String> likeSentList = [];
  List<String> likeReceivedList = [];
  List likesList = [];

  getLikedListKeys()async{

    if(isLikeSentClicked){
      var likeSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("likeSent")
          .get();

      for(int i=0; i<likeSentDocument.docs.length; i++){
        likeSentList.add(likeSentDocument.docs[i].id);
      }
      print("Like Sent List: "+ likeSentList.toString());
      getKeysDataFromUsersCollections(likeSentList);
    }
    else{
      var likeReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("likeReceived")
          .get();

      for(int i=0; i<likeReceivedDocument.docs.length; i++){
        likeSentList.add(likeReceivedDocument.docs[i].id);
      }
      print("Liked Received List: "+ likeReceivedList.toString());
      getKeysDataFromUsersCollections(likeReceivedList);
    }
  }

  getKeysDataFromUsersCollections(List<String> keysList)async{
    var allUsersDocument = await FirebaseFirestore.instance
        .collection("users").get();

    for(int i=0; i<allUsersDocument.docs.length; i++){
      for(int k=0; k<keysList.length; k++){
        if (((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keysList[k]){
          likesList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      likesList;
    });
print("Liked List: "+ likesList.toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLikedListKeys();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              likesList.clear();
              likeSentList = [];
              likeReceivedList = [];
              likesList.clear();
              likesList = [];

              setState(() {
                isLikeSentClicked = true;
              });

              getLikedListKeys();
            },
                child: Text(
                  "My Likes",
                  style: TextStyle(
                    color: isLikeSentClicked? Colors.white : Colors.grey,
                    fontWeight:  isLikeSentClicked? FontWeight.bold : FontWeight.normal,
                    fontSize: 24,
                  ),
                )),
            Text(
              "   |   ",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            TextButton(onPressed: (){
              likesList.clear();
              likeSentList = [];
              likeReceivedList = [];
              likesList.clear();
              likesList = [];

              setState(() {
                isLikeSentClicked = false;
              });

              getLikedListKeys();
            },
                child: Text(
                  "I am Liked By",
                  style: TextStyle(
                    color: isLikeSentClicked? Colors.grey : Colors.white,
                    fontWeight:  isLikeSentClicked? FontWeight.normal : FontWeight.bold,
                    fontSize: 24,
                  ),
                )),
          ],
        ),
      ),
      body: likesList.isEmpty?
      Center(
        child: Icon(
          Icons.person_off_sharp,
          color: Colors.white,
          size: 60,
        ),
      ):
      GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        children: List.generate(likesList.length, (index){
          return GridTile(child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                color: Colors.blue.shade200,
                child: GestureDetector(
                  onTap: (){},
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(likesList[index]["imageProfile"],),
                            fit: BoxFit.cover
                        )
                    ),
                    child: Padding(padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const Spacer(),

                            Expanded(
                              child:
                              Text(
                                likesList[index]["name"]+" . "+likesList[index]["age"].toString(),
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),

                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),

                            Row(
                              children: [
                                const Icon(
                                  Icons.location_city_outlined,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    likesList[index]["city"]+" , "+likesList[index]["country"],
                                    maxLines: 2,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),

                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),),
                ),
              )
          ));
        }),
      ),
    );
  }
}
