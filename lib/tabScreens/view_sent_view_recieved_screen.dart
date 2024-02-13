import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tindaa/controllers/global.dart';

class ViewSentViewRecievedScreen extends StatefulWidget {
  const ViewSentViewRecievedScreen({super.key});

  @override
  State<ViewSentViewRecievedScreen> createState() => _ViewSentViewRecievedScreenState();
}

class _ViewSentViewRecievedScreenState extends State<ViewSentViewRecievedScreen> {

  bool isViewSentClicked = true;
  List<String> viewSentList = [];
  List<String> viewReceivedList = [];
  List viewsList = [];

  getViewedListKeys()async{

    if(isViewSentClicked){
      var likeSentDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("likeSent")
          .get();

      for(int i=0; i<likeSentDocument.docs.length; i++){
        viewSentList.add(likeSentDocument.docs[i].id);
      }
      print("Like Sent List: "+ viewSentList.toString());
      getKeysDataFromUsersCollections(viewSentList);
    }
    else{
      var likeReceivedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId.toString())
          .collection("likeReceived")
          .get();

      for(int i=0; i<likeReceivedDocument.docs.length; i++){
        viewSentList.add(likeReceivedDocument.docs[i].id);
      }
      print("Liked Received List: "+ viewReceivedList.toString());
      getKeysDataFromUsersCollections(viewReceivedList);
    }
  }

  getKeysDataFromUsersCollections(List<String> keysList)async{
    var allUsersDocument = await FirebaseFirestore.instance
        .collection("users").get();

    for(int i=0; i<allUsersDocument.docs.length; i++){
      for(int k=0; k<keysList.length; k++){
        if (((allUsersDocument.docs[i].data() as dynamic)["uid"]) == keysList[k]){
          viewsList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      viewsList;
    });
    print("Liked List: "+ viewsList.toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getViewedListKeys();
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
              viewsList.clear();
              viewSentList = [];
              viewReceivedList = [];
              viewsList.clear();
              viewsList = [];

              setState(() {
                isViewSentClicked = true;
              });

              getViewedListKeys();
            },
                child: Text(
                  "My Views",
                  style: TextStyle(
                    color: isViewSentClicked? Colors.white : Colors.grey,
                    fontWeight:  isViewSentClicked? FontWeight.bold : FontWeight.normal,
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
              viewsList.clear();
              viewSentList = [];
              viewReceivedList = [];
              viewsList.clear();
              viewsList = [];

              setState(() {
                isViewSentClicked = false;
              });

              getViewedListKeys();
            },
                child: Text(
                  "Viewed by",
                  style: TextStyle(
                    color: isViewSentClicked? Colors.grey : Colors.white,
                    fontWeight:  isViewSentClicked? FontWeight.normal : FontWeight.bold,
                    fontSize: 24,
                  ),
                )),
          ],
        ),
      ),
      body: viewsList.isEmpty?
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
        children: List.generate(viewsList.length, (index){
          return GridTile(child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                color: Colors.blue.shade200,
                child: GestureDetector(
                  onTap: (){},
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(viewsList[index]["imageProfile"],),
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
                                viewsList[index]["name"]+" . "+viewsList[index]["age"].toString(),
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
                                    viewsList[index]["city"]+" , "+viewsList[index]["country"],
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
