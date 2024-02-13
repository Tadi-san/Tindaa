import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tindaa/controllers/global.dart';

class FavoriteSentFavoriteRecievedScreen extends StatefulWidget {
  const FavoriteSentFavoriteRecievedScreen({super.key});

  @override
  State<FavoriteSentFavoriteRecievedScreen> createState() => _FavoriteSentFavoriteRecievedScreenState();
}

class _FavoriteSentFavoriteRecievedScreenState extends State<FavoriteSentFavoriteRecievedScreen> {

  bool isFavoriteSentClicked = true;
  List<String> favoriteSentList = [];
  List<String> favoriteReceivedList = [];
  List favoritesList = [];

  getFavoriteListKeys()async{

    if(isFavoriteSentClicked){
      var favoriteSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("favoriteSent")
          .get();

      for(int i=0; i<favoriteSentDocument.docs.length; i++){
        favoriteSentList.add(favoriteSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollections(favoriteSentList);
    }
    else{
      var favoriteReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("favoriteReceived")
          .get();

      for(int i=0; i<favoriteReceivedDocument.docs.length; i++){
        favoriteSentList.add(favoriteReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollections(favoriteReceivedList);
    }
  }

  getKeysDataFromUsersCollections(List<String> keysList)async{
    var allUsersDocument = await FirebaseFirestore.instance
        .collection("users").get();

    for(int i=0; i<allUsersDocument.docs.length; i++){
      for(int k=0; k<keysList.length; k++){
        if (((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keysList[k]){
          favoritesList.add(allUsersDocument.docs[i].data());
        }
      }
    }

  setState(() {
    favoritesList;
  });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavoriteListKeys();
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
              favoritesList.clear();
              favoriteSentList = [];
              favoriteReceivedList = [];
              favoritesList.clear();
              favoritesList = [];

              setState(() {
                isFavoriteSentClicked = true;
              });

              getFavoriteListKeys();
            },
                child: Text(
                  "My Favorites",
                  style: TextStyle(
                    color: isFavoriteSentClicked? Colors.white : Colors.grey,
                    fontWeight:  isFavoriteSentClicked? FontWeight.bold : FontWeight.normal,
                    fontSize: 24,
                  ),
                )),
            const Text(
              "   |   ",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            TextButton(onPressed: (){
              favoritesList.clear();
              favoriteSentList = [];
              favoriteReceivedList = [];
              favoritesList.clear();
              favoritesList = [];

              setState(() {
                isFavoriteSentClicked = false;
              });

              getFavoriteListKeys();
            },
                child: Text(
                  "Favorited by",
                  style: TextStyle(
                    color: isFavoriteSentClicked? Colors.grey : Colors.white,
                    fontWeight:  isFavoriteSentClicked? FontWeight.normal : FontWeight.bold,
                    fontSize: 24,
                  ),
                )),
          ],
        ),
      ),
        body: favoritesList.isEmpty?
         const Center(
          child: Icon(
        Icons.person_off_sharp,
            color: Colors.white,
            size: 60,
          ),
        ):
        GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8),
          children: List.generate(favoritesList.length, (index){
            return GridTile(child: Padding(
              padding: const EdgeInsets.all(2.0),
            child: Card(
              color: Colors.blue.shade200,
              child: GestureDetector(
                onTap: (){},
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(favoritesList[index]["imageProfile"],),
                      fit: BoxFit.cover
                    )
                  ),
                child: Padding(padding: const EdgeInsets.all(8.0),
               child: Center(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     const Spacer(),

                         Expanded(
                           child:
                             Text(
                               favoritesList[index]["name"]+" . "+favoritesList[index]["age"].toString(),
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
                                 favoritesList[index]["city"]+" , "+favoritesList[index]["country"],
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
