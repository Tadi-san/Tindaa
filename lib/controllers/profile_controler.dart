import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tindaa/controllers/global.dart';
import 'package:tindaa/models/person.dart';

class ProfileControler extends GetxController {
  final Rx<List<Person>> userProfileList = Rx<List<Person>>([]);

  List<Person> get allUsersProfileList => userProfileList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userProfileList.bindStream(
        FirebaseFirestore.instance.collection("users")
            .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots()
            .map((QuerySnapshot queryDataSnapshot) {
          List<Person> profilesList = [];
          for (var eachProfile in queryDataSnapshot.docs) {
            profilesList.add(Person.formdataSnapshot(eachProfile));
          }
          return profilesList;
        })
    );
  }

  favoriteSentAndFavoriteRecieved(String toUserId, String senderName)
  async
  {
    try {
      var document = await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserId).collection("favoriteReceived").doc(currentUserId)
          .get();
      // remove fav
      if (document.exists){
        // remove curr user from the reciver
        await FirebaseFirestore.instance
            .collection("users")
            .doc(toUserId).collection("favoriteReceived").doc(currentUserId)
            .delete();
        // remove reciver  from the curr user
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserId).collection("favoriteSent").doc(toUserId)
            .delete();
      }
      // add fav
      else{
        // add curr user to the reciver
        await FirebaseFirestore.instance
            .collection("users")
            .doc(toUserId).collection("favoriteReceived").doc(currentUserId)
            .set({});
        // add reciver  to the curr user
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserId).collection("favoriteSent").doc(toUserId)
            .set({});
        // send notfication
      }

      update();


    } catch (e) {
      print('Error: $e');
    }
  }


  LikeSentAndLikeRecieved(String toUserId, String senderName)
  async
  {
    try {
      var document = await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserId).collection("likeReceived").doc(currentUserId)
          .get();
      // remove like
      if (document.exists){
        // remove curr user from the reciver
        await FirebaseFirestore.instance
            .collection("users")
            .doc(toUserId).collection("likeReceived").doc(currentUserId)
            .delete();
        // remove like  from the curr user
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserId).collection("likeSent").doc(toUserId)
            .delete();
      }
      // add fav
      else{
        // add like to curr user to the reciver
        await FirebaseFirestore.instance
            .collection("users")
            .doc(toUserId).collection("likeReceived").doc(currentUserId)
            .set({});
        // add reciver like to the curr user
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserId).collection("likeSent").doc(toUserId)
            .set({});
        // send notfication
      }

      update();
    } catch (e) {
      print('Error: $e');
    }
  }

  ViewSentAndViewRecieved(String toUserId, String senderName)
  async
  {

    try {
      var document = await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserId).collection("viewReceived").doc(currentUserId)
          .get();
      // remove like
      if (document.exists){
        print("already in view list");
      }
      // add fav
      else{
        // add new view to DB
        await FirebaseFirestore.instance
            .collection("users")
            .doc(toUserId).collection("viewReceived").doc(currentUserId)
            .set({});
        // add reciver like to the curr user viewed list
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserId).collection("LikeReceived").doc(currentUserId)
            .set({});
        // send notfication
      }

      update();
    }


    catch(e)
{
  print("Error: $e");
}
}

}