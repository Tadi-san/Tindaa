import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tindaa/HomeScreen/home_screen.dart';
import 'package:tindaa/controllers/global.dart';
import 'package:tindaa/widgets/custom_text_field_widget.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {

 bool uploading = false, next = false;
 final List<File> _image = [];
 List<String> urlList = [];
 double val = 0;
 var showProgressBar = true;
 // personal info
 TextEditingController nameTextEditingController = TextEditingController();
 TextEditingController ageTextEditingController = TextEditingController();
 TextEditingController phoneNoTextEditingController = TextEditingController();
 TextEditingController cityTextEditingController = TextEditingController();
 TextEditingController countryTextEditingController = TextEditingController();
 TextEditingController profileHeadingTextEditingController =
 TextEditingController();
 TextEditingController lookingForInaPartnerTextEditingController =
 TextEditingController();
// appearance
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyTypeTextEditingController = TextEditingController();

  // life style
  TextEditingController drinkTextEditingController = TextEditingController();
  TextEditingController smokeTextEditingController = TextEditingController();
  TextEditingController haveChildrenTextEditingController =
  TextEditingController();
  TextEditingController noOfChildrenTextEditingController =
  TextEditingController();
  TextEditingController professionTextEditingController =
  TextEditingController();
  TextEditingController employmentStatusTextEditingController =
  TextEditingController();
  TextEditingController incomeTextEditingController = TextEditingController();
  TextEditingController livingSituationTextEditingController =
  TextEditingController();
  TextEditingController willingToRelocateTextEditingController =
  TextEditingController();
  TextEditingController relationshipYouAreLookingForTextEditingController =
  TextEditingController();
  TextEditingController martialStatusTextEditingController =
  TextEditingController();
  // background -cultural values
  TextEditingController nationalityTextEditingController =
  TextEditingController();
  TextEditingController educationTextEditingController =
  TextEditingController();
  TextEditingController languageSpokenTextEditingController =
  TextEditingController();
  TextEditingController religionTextEditingController = TextEditingController();
  TextEditingController ethnicityTextEditingController =
  TextEditingController();

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



  chooseImage()async {
   XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
   
   setState(() {
     _image.add(File(pickedFile!.path));
   });

 }

 uploadImages() async {
   int i = 1;
    
   for (var img in _image ){
      setState(() {
        val = i/_image.length;
      });
   var refImages = FirebaseStorage.instance
       .ref()
       .child("images/${DateTime.now().microsecondsSinceEpoch.toString()}.jpg");
    await refImages.putFile(img).whenComplete(() async {
      await refImages.getDownloadURL().then((urlImage){
        urlList.add(urlImage);
        i++;
      });
    });
   }
 }

 retrieveUserData()async {
   await FirebaseFirestore.instance
       .collection("users")
       .doc(currentUserId)
       .get()
       .then((snapshot){
         if (snapshot.exists){

           setState(() {
             name = snapshot.data()!["name"];
             nameTextEditingController.text = name!;
             age = snapshot.data()!["age"].toString();
             ageTextEditingController.text = age!;
             phoneNo = snapshot.data()!["phoneNo"];
             phoneNoTextEditingController.text = phoneNo!;
             city = snapshot.data()!["city"];
             cityTextEditingController.text = city!;
             country = snapshot.data()!["country"];
             countryTextEditingController.text = country!;
             profileHeading = snapshot.data()!["profileHeading"];
             profileHeadingTextEditingController.text = profileHeading!;
             lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];
             lookingForInaPartnerTextEditingController.text = lookingForInaPartner!;
             height = snapshot.data()!["height"];
             heightTextEditingController.text = height!;
             weight = snapshot.data()!["weight"];
             weightTextEditingController.text = weight!;
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

  updateUserDataToFirestoreDatabase(
      String name,
      String age,
      String phoneNo,
      String city,
      String country,
      String profileHeading,
      String lookingForInaPartner,
      String height,
      String weight,
      String bodyType,
      String drink,
      String smoke,
      String martialStatus,
      String haveChildren,
      String noOfChildren,
      String profession,
      String employmentStatus,
      String income,
      String livingSituation,
      String willingToRelocate,
      String relationshipYouAreLookingFor,
      String nationality,
      String education,
      String languageSpoken,
      String religion,
      String ethnicity,


      ) async {


    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            content: SizedBox(
              height: 150,

              child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Uploading Images.. ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                  ),

                ],
              )),
            ),
          );
        }
    );
    await uploadImages();
    
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .update({

      "name": name,
      "age": int.parse(age),
      "phoneNo": phoneNo,
      "city": city,
      "country": country,
      "profileHeading": profileHeading,
      "lookingForInaPartner": lookingForInaPartner,
      "height": height,
      "weight": weight,
      "bodyType": bodyType,
      "drink": drink,
      "smoke": smoke,
      "martialStatus": martialStatus,
      "haveChildren": haveChildren,
      "noOfChildren": noOfChildren,
      "profession": profession,
      "employmentStatus": employmentStatus,
      "income": income,
      "livingSituation": livingSituation,
      "willingToRelocate": willingToRelocate,
      "relationshipYouAreLookingFor": relationshipYouAreLookingFor,
      "nationality": nationality,
      "education": education,
      "languageSpoken": languageSpoken,
      "religion": religion,
      "ethnicity": ethnicity,

      //images

      "urlImage1": urlList[0].toString(),
      "urlImage2": urlList[1].toString(),
      "urlImage3": urlList[2].toString(),
      "urlImage4": urlList[3].toString(),
      "urlImage5": urlList[4].toString(),
    });

    Get.snackbar("Updated", "your account has been updated.");

    Get.to(HomeScreen());

    setState(() {
      uploading = false;
      _image.clear();
      urlList = [];


    });
  }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveUserData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          next ? "Profile Information"
              :"Choose 5 Images",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,

          ),
        ),
        actions: [
          next ? Container()
              : IconButton(onPressed: (){

                if (_image.length == 5){
                  setState(() {
                    uploading = false;
                    next = true;
                  });
                }
                else{
                  Get.snackbar("5 images", "please choose 5 images");
                }
          },
              icon: const Icon(Icons.navigate_next_outlined, size: 36,)
          ,),

        ],
      ),
      body:next
          ? SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
       children: [
         // personal info
         const SizedBox(
           height: 2,
         ),
         const Text(
           "Personal Infos",
           style: TextStyle(
             fontSize: 18,
             color: Colors.grey,
             fontWeight: FontWeight.bold,
           ),
         ),
         const SizedBox(
           height: 10,
         ),
         //name
         SizedBox(
           width:  MediaQuery.of(context).size.width - 36,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: nameTextEditingController,
             lableText: "Name",
             iconData: Icons.person_outline,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //Age
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: ageTextEditingController,
             lableText: "Age",
             iconData: Icons.numbers_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //PhoneNo
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: phoneNoTextEditingController,
             lableText: "PhoneNo",
             iconData: Icons.phone_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //City
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: cityTextEditingController,
             lableText: "City",
             iconData: Icons.location_city_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //City
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: countryTextEditingController,
             lableText: "Country",
             iconData: Icons.location_city_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //ProfileHeading
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: profileHeadingTextEditingController,
             lableText: "Profile Heading",
             iconData: Icons.text_fields_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //Looking For in a partner
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: lookingForInaPartnerTextEditingController,
             lableText: "What You're Looking For In a Partner",
             iconData: Icons.text_fields_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),

         // Appearance
         const Text(
           "Appearance",
           style: TextStyle(
             fontSize: 18,
             color: Colors.grey,
             fontWeight: FontWeight.bold,
           ),
         ),
         // appearance
         const SizedBox(
           height: 10,
         ),
         const SizedBox(
           height: 20,
         ),
         //Height
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: heightTextEditingController,
             lableText: "your Height",
             iconData: Icons.numbers_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //weight
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: weightTextEditingController,
             lableText: "your Weight",
             iconData: Icons.numbers_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //Body Type
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: bodyTypeTextEditingController,
             lableText: "your Body Type",
             iconData: Icons.numbers_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //Life Style
         const SizedBox(
           height: 20,
         ),

         // life style
         const Text(
           "Life Style",
           style: TextStyle(
             fontSize: 18,
             color: Colors.grey,
             fontWeight: FontWeight.bold,
           ),
         ),
         // life style
         const SizedBox(
           height: 10,
         ),
         //Drink
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: drinkTextEditingController,
             lableText: "Drink",
             iconData: Icons.local_drink_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //Smoke
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: smokeTextEditingController,
             lableText: "Smoke",
             iconData: Icons.smoke_free_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: willingToRelocateTextEditingController,
             lableText: "Are you married ?",
             iconData: Icons.travel_explore_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //have children
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: haveChildrenTextEditingController,
             lableText: "Have Children",
             iconData: Icons.baby_changing_station_outlined,
             isObscure: false,
           ),
         ),

         const SizedBox(
           height: 20,
         ),
         //No Children
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: noOfChildrenTextEditingController,
             lableText: "Number of Children",
             iconData: Icons.child_friendly_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //Profession
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: professionTextEditingController,
             lableText: "Profession",
             iconData: Icons.work_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //employment Status
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: employmentStatusTextEditingController,
             lableText: "EmploymentStatus",
             iconData: Icons.work_history_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //income
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: incomeTextEditingController,
             lableText: "Income",
             iconData: Icons.money_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //Living situation
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: livingSituationTextEditingController,
             lableText: "Living Situation",
             iconData: Icons.house_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         //Willing to relocate
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: willingToRelocateTextEditingController,
             lableText: "What You're Looking For In a Partner",
             iconData: Icons.travel_explore_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),

         // relationship you're looking for
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController:
             relationshipYouAreLookingForTextEditingController,
             lableText: "What Kind Of Relationship Are You Looking For ?",
             iconData: Icons.heart_broken_sharp,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),

         // cultural values
         const Text(
           "Cultural Values",
           style: TextStyle(
             fontSize: 18,
             color: Colors.grey,
             fontWeight: FontWeight.bold,
           ),
         ),
         // cultural values
         const SizedBox(
           height: 10,
         ),
         const SizedBox(
           height: 20,
         ),
         // /Nationality
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: nationalityTextEditingController,
             lableText: "What's Your Nationality",
             iconData: Icons.people_alt_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         // Education
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: educationTextEditingController,
             lableText: "Level of education",
             iconData: Icons.rotate_90_degrees_ccw_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         const SizedBox(
           height: 20,
         ),
         //Religion
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: religionTextEditingController,
             lableText: "What's Your Religion",
             iconData: Icons.people_alt_outlined,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         // Ethnicity
         SizedBox(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           child: CustomTextFieldWidget(
             editingController: ethnicityTextEditingController,
             lableText: "your Ethnicity ?",
             iconData: Icons.heart_broken_sharp,
             isObscure: false,
           ),
         ),
         const SizedBox(
           height: 20,
         ),
         const SizedBox(
           height: 30,
         ),
         // Register Button
         Container(
           width: MediaQuery.of(context).size.width - 10,
           height: 55,
           decoration: const BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.all(Radius.circular(12))),
           child: InkWell(
             onTap: () async {
               if (
               nameTextEditingController.text.trim().isNotEmpty
               // &&
               //     emailTextEditingController.text.trim().isNotEmpty &&
               //     passwordTextEditingController.text.trim().isNotEmpty &&
               //     phoneNoTextEditingController.text.trim().isNotEmpty &&
               //     ageTextEditingController.text.trim().isNotEmpty &&
               //     cityTextEditingController.text.trim().isNotEmpty &&
               //     countryTextEditingController.text.trim().isNotEmpty &&
               //     profileHeadingTextEditingController.text
               //         .trim()
               //         .isNotEmpty &&
               //     lookingForInaPartnerTextEditingController.text
               //         .trim()
               //         .isNotEmpty &&
               //     heightTextEditingController.text.trim().isNotEmpty &&
               //     weightTextEditingController.text.trim().isNotEmpty &&
               //     bodyTypeTextEditingController.text.trim().isNotEmpty &&
               //     drinkTextEditingController.text.trim().isNotEmpty &&
               //     smokeTextEditingController.text.trim().isNotEmpty &&
               //     martialStatusTextEditingController.text
               //         .trim()
               //         .isNotEmpty &&
               //     haveChildrenTextEditingController.text
               //         .trim()
               //         .isNotEmpty &&
               //     noOfChildrenTextEditingController.text
               //         .trim()
               //         .isNotEmpty &&
               //     professionTextEditingController.text
               //         .trim()
               //         .isNotEmpty &&
               //     employmentStatusTextEditingController.text
               //         .trim()
               //         .isNotEmpty &&
               //     incomeTextEditingController.text.trim().isNotEmpty &&
               //     livingSituationTextEditingController.text
               //         .trim()
               //         .isNotEmpty
               // &&
               //     relationshipYouAreLookingForTextEditingController.text
               //         .trim()
               //         .isNotEmpty &&
               //     nationalityTextEditingController.text
               //         .trim()
               //         .isNotEmpty &&
               //     languageSpokenTextEditingController.text
               //         .trim()
               //         .isNotEmpty &&
               //     ethnicityTextEditingController.text.trim().isNotEmpty
               ) {
                 setState(() {
                   showProgressBar = true;
                 });
                 _image.isNotEmpty ?
                 await updateUserDataToFirestoreDatabase(
                   // authenticationController.ProfileImage!,
                   nameTextEditingController.text.trim(),
                   ageTextEditingController.text.trim(),
                   phoneNoTextEditingController.text.trim(),
                   cityTextEditingController.text.trim(),
                   countryTextEditingController.text.trim(),
                   profileHeadingTextEditingController.text.trim(),
                   lookingForInaPartnerTextEditingController.text.trim(),
                   heightTextEditingController.text.trim(),
                   weightTextEditingController.text.trim(),
                   bodyTypeTextEditingController.text.trim(),
                   drinkTextEditingController.text.trim(),
                   smokeTextEditingController.text.trim(),
                   martialStatusTextEditingController.text.trim(),
                   haveChildrenTextEditingController.text.trim(),
                   noOfChildrenTextEditingController.text.trim(),
                   professionTextEditingController.text.trim(),
                   employmentStatusTextEditingController.text.trim(),
                   incomeTextEditingController.text.trim(),
                   livingSituationTextEditingController.text.trim(),
                   willingToRelocateTextEditingController.text.trim(),
                   relationshipYouAreLookingForTextEditingController.text
                       .trim(),
                   nationalityTextEditingController.text.trim(),
                   educationTextEditingController.text.trim(),
                   languageSpokenTextEditingController.text.trim(),
                   religionTextEditingController.text.trim(),
                   ethnicityTextEditingController.text.trim(),

                 ) :null;
                 setState(() {
                   showProgressBar = false;
                   // authenticationController.imageFile = null;
                 });
               }
             },
             child: const Center(
                 child: Text("Update",
                     style: TextStyle(
                       fontSize: 20,
                       color: Colors.black,
                       fontWeight: FontWeight.bold,
                     ))),
           ),
         ),

         const SizedBox(
           height: 15,
         ),




       ],
        )
          ,),
      )
          : Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child: GridView.builder(
              itemCount: _image.length+1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index){
                return index == 0
                    ? Container(
                  color: Colors.white30,
                  child: Center(
                    child: IconButton(
                      onPressed: (){
                        if(_image.length < 5){

                          !uploading ? chooseImage(): null ;
                        }
                        else{
                          setState(() {
                            uploading = true;
                          });
                        }

                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                )
                    : Container(
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(
                            _image[index -1],
                        ),
                      fit: BoxFit.cover,
                    )
                  ),
                ) ;
              },
            ),
          ),
        ],
      ) ,
    );
  }
}
