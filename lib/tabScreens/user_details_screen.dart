import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';
import 'package:tindaa/controllers/global.dart';
import 'package:tindaa/widgets/settings_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  String? userId;

  UserDetailsScreen({
    super.key,
    this.userId,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  // personal info
  String? imageProfile = "";
  String? name = "";
  String? age = "";
  String? phoneNo = "";
  String? city = "";
  String? country = "";
  String? profileHeading = "";
  String? lookingForInaPartner = "";

  // Appearance
  String? height = "";
  String? weight = "";
  String? bodyType = "";

  // Life style
  String? drink = "";
  String? smoke = "";
  String? martialStatus = "";
  String? haveChildren = "";
  String? noOfChildren = "";
  String? profession = "";
  String? employmentStatus = "";
  String? income = "";
  String? livingSituation = "";
  String? willingToRelocate = "";
  String? relationshipYouAreLookingFor = "";

  // Background
  String? nationality = "";
  String? education = "";
  String? languageSpoken = "";
  String? religion = "";
  String? ethnicity = "";

  // slider images

  String? urlImage1 =
      "https://firebasestorage.googleapis.com/v0/b/tinda-d3b93.appspot.com/o/Place%20Holder%2FDrippy%20LED%20Light%20Pimped%20Facetime%20Cat%20Icon.jpg?alt=media&token=1bc74a31-d4f2-4e67-a47e-9699747cb285";
  String? urlImage2 =
      "https://firebasestorage.googleapis.com/v0/b/tinda-d3b93.appspot.com/o/Place%20Holder%2FDrippy%20LED%20Light%20Pimped%20Facetime%20Cat%20Icon.jpg?alt=media&token=1bc74a31-d4f2-4e67-a47e-9699747cb285";
  String? urlImage3 =
      "https://firebasestorage.googleapis.com/v0/b/tinda-d3b93.appspot.com/o/Place%20Holder%2FDrippy%20LED%20Light%20Pimped%20Facetime%20Cat%20Icon.jpg?alt=media&token=1bc74a31-d4f2-4e67-a47e-9699747cb285";
  String? urlImage4 =
      "https://firebasestorage.googleapis.com/v0/b/tinda-d3b93.appspot.com/o/Place%20Holder%2FDrippy%20LED%20Light%20Pimped%20Facetime%20Cat%20Icon.jpg?alt=media&token=1bc74a31-d4f2-4e67-a47e-9699747cb285";
  String? urlImage5 =
      "https://firebasestorage.googleapis.com/v0/b/tinda-d3b93.appspot.com/o/Place%20Holder%2FDrippy%20LED%20Light%20Pimped%20Facetime%20Cat%20Icon.jpg?alt=media&token=1bc74a31-d4f2-4e67-a47e-9699747cb285";

  retrieveUserInfo() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.data()!["urlImage1"] != null) {
          setState(() {
            urlImage1 = snapshot.data()!["urlImage1"];
            urlImage2 = snapshot.data()!["urlImage2"];
            urlImage3 = snapshot.data()!["urlImage3"];
            urlImage4 = snapshot.data()!["urlImage4"];
            urlImage5 = snapshot.data()!["urlImage5"];
          });
        }

        setState(() {
          name = snapshot.data()!["name"];
          imageProfile = snapshot.data()!["imageProfile"];
          age = snapshot.data()!["age"].toString();
          phoneNo = snapshot.data()!["phoneNo"];
          city = snapshot.data()!["city"];
          country = snapshot.data()!["country"];
          profileHeading = snapshot.data()!["profileHeading"];
          lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];
          height = snapshot.data()!["height"];
          weight = snapshot.data()!["weight"];
          bodyType = snapshot.data()!["bodyType"];
          drink = snapshot.data()!["drink"];
          smoke = snapshot.data()!["smoke"];
          martialStatus = snapshot.data()!["martialStatus"];
          haveChildren = snapshot.data()!["haveChildren"];
          noOfChildren = snapshot.data()!["noOfChildren"];
          profession = snapshot.data()!["profession"];
          employmentStatus = snapshot.data()!["employmentStatus"];
          income = snapshot.data()!["income"];
          livingSituation = snapshot.data()!["livingSituation"];
          willingToRelocate = snapshot.data()!["willingToRelocate"];
          relationshipYouAreLookingFor =
              snapshot.data()!["relationshipYouAreLookingFor"];
          nationality = snapshot.data()!["nationality"];
          education = snapshot.data()!["education"];
          languageSpoken = snapshot.data()!["languageSpoken"];
          religion = snapshot.data()!["religion"];
          ethnicity = snapshot.data()!["ethnicity"];
        });


      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading:
            widget.userId == currentUserId ? false : true,
        actions: [
          widget.userId == currentUserId
              ? Row(
                  children: [
                    //sign out
                    IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 30,
                        )),
                    //setting
                    IconButton(
                        onPressed: () {
                          Get.to(AccountSettingsScreen());
                        },
                        icon: const Icon(
                          Icons.settings_outlined,
                          size: 30,
                        )),
                  ],
                )
              : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              //image slider
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Carousel(
                      indicatorBarColor: Colors.black.withOpacity(0.3),
                      autoScrollDuration: const Duration(seconds: 2),
                      animationPageDuration: const Duration(milliseconds: 500),
                      activateIndicatorColor: Colors.black,
                      animationPageCurve: Curves.easeIn,
                      indicatorBarHeight: 30,
                      indicatorWidth: 10,
                      indicatorHeight: 10,
                      unActivatedIndicatorColor: Colors.grey,
                      stopAtEnd: false,
                      autoScroll: true,
                      items: [
                        Image.network(
                          urlImage1!,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage2!,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage3!,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage4!,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage5!,
                          fit: BoxFit.cover,
                        ),
                      ]),
                ),
              ),

              const SizedBox(
                height: 10.0,
              ),

              //personal info title
              const SizedBox(
                height: 30.0,
              ),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Personal Info:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Divider(
                color: Colors.white,
                thickness: 2,
              ),

              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(children: [
                  // name
                  TableRow(children: [
                    const Text(
                      "Name: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      name ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ]),
                  // table row spacing
                  const TableRow(children: [
                    Text(""),
                    Text(""),
                  ]),
                  // age
                  TableRow(children: [
                    const Text(
                      "Age: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      age ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ]),
                  //Phone No
                  const TableRow(children: [
                    Text(""),
                    Text(""),
                  ]),

                  TableRow(children: [
                    const Text(
                      "Phone Number: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      phoneNo ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ]),

                  //Looking for in r/n ship
                  const TableRow(children: [
                    Text(""),
                    Text(""),
                  ]),

                  TableRow(children: [
                    const Text(
                      "Looking for in a relationship: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      lookingForInaPartner ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ]),
                  //city
                  const TableRow(children: [
                    Text(""),
                    Text(""),
                  ]),

                  TableRow(children: [
                    const Text(
                      "City: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      city ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ]),
                  //country
                  const TableRow(children: [
                    Text(""),
                    Text(""),
                  ]),

                  TableRow(children: [
                    const Text(
                      "Country: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      country ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ]),

                  //profile heading
                  const TableRow(children: [
                    Text(""),
                    Text(""),
                  ]),
                  TableRow(children: [
                    const Text(
                      "Profile Heading: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      profileHeading ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ]),
                  // height
                  const TableRow(children: [
                    Text(""),
                    Text(""),
                  ]),
                ]),
              ),

              //Apreance
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Appearance:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    // height
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Height: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        height ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    //Weight
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Weight: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        weight ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //Body Type
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Body Type: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        bodyType ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),

              //Life style
              const SizedBox(
                height: 30.0,
              ),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Life Style:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    //Drink
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Drink: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        drink ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    //smoke
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Smoke: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        smoke ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //martial Status
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Martial Status: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        martialStatus ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    //Have children
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Have children: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        haveChildren ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    //no of children
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Number of children: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        noOfChildren ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    //profession
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Profession: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        profession ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //employmentStatus
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),
                    TableRow(children: [
                      const Text(
                        "Employment Status: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        employmentStatus ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    // income
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Income: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        income ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    //Living situation
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Living Situation: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        livingSituation ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //Willing to relocate
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Willing to Relocate: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        willingToRelocate ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    //Relationship looking for
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Relation ship Looking For: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        relationshipYouAreLookingFor ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              //Back ground
              const SizedBox(
                height: 30.0,
              ),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Background and Cultural Values:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    //nationality
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Nationality: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        nationality ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    //education
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Education: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        education ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //language spoken
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Language Spoken: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        languageSpoken ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    //religion
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Religion: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        religion ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    //Ethinicity
                    const TableRow(children: [
                      Text(""),
                      Text(""),
                    ]),

                    TableRow(children: [
                      const Text(
                        "Ethnicity: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        ethnicity ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
