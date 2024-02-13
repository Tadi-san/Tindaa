import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class PushNotficationSystem
{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //notfication arrived/recieved

  Future whenNotificationReceived(BuildContext context) async
  {
    // 1 when the app was closed then opened from the notfication
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? remoteMessage)
      {
        if(remoteMessage != null){
          // open app and show notfication
          openAppAndShowNotfication(
            remoteMessage.data["userID"],
            remoteMessage.data["senderID"],
            context,
          );
        }
      });
    // 2 when the app is open and recieves a notfication

    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {

      if(remoteMessage != null){
        // open app and show notfication
        openAppAndShowNotfication(
          remoteMessage.data["userID"],
          remoteMessage.data["senderID"],
          context,
        );
      }
    });

    // 3 when the app is open on the back ground and directy opend from the notfication

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {

      if(remoteMessage != null){
        // open app and show notfication
        openAppAndShowNotfication(
          remoteMessage.data["userID"],
          remoteMessage.data["senderID"],
          context,
        );
      }
    });
  }


  openAppAndShowNotfication(receiverID, senderID, context){

  }
}