import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tindaa/tabScreens/favorite%20_sent_favorite_recieved_screen.dart';
import 'package:tindaa/tabScreens/like_sent_like_recieved_screen.dart';
import 'package:tindaa/tabScreens/swipping_screen.dart';
import 'package:tindaa/tabScreens/user_details_screen.dart';
import 'package:tindaa/tabScreens/view_sent_view_recieved_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int screenIndex = 0;
  List tabScreenList = [
    SwippingScreen(),
    ViewSentViewRecievedScreen(),
    FavoriteSentFavoriteRecievedScreen(),
    LikeSentLikeRecievedScreen(),
    UserDetailsScreen(userId: FirebaseAuth.instance.currentUser!.uid,),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNo){
          setState(() {
            screenIndex = indexNo;
          });

        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.white12,
        currentIndex: screenIndex,
        items: const [
          BottomNavigationBarItem(icon:
          Icon(
            Icons.home,
            size:33,
          ), label: ""
          ),
          // Home
          BottomNavigationBarItem(icon:
        Icon(
          Icons.remove_red_eye,
          size:30,
        ), label: ""
        ),
         // Liked
          BottomNavigationBarItem(icon:
          Icon(
              Icons.star,
              size:30,
          ),
              label: ""
          ),
          // Favorite
          BottomNavigationBarItem(icon:
          Icon(
              Icons.favorite,
              size:30,
          ),
              label: ""
          ),
  // User Details
          BottomNavigationBarItem(icon:
          Icon(
              Icons.person,
              size:30,
          ),
              label: ""
          ),
        ],
      ),
      body: tabScreenList[screenIndex],
    );
  }
}
