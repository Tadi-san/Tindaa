import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tindaa/HomeScreen/home_screen.dart';
import 'package:tindaa/auth_screens/login.dart';
import 'package:tindaa/auth_screens/registeration_screen.dart';
import 'package:tindaa/models/person.dart' as personModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController authController = Get.find();
  late Rx<User?> firebaseCurrentUser;
  late Rx<File?> pickedFile;
  File? get ProfileImage => pickedFile.value;

  XFile? imageFile;

  pickImageFromGallery() async {
     imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      Get.snackbar("Profile Image",
          "You Have Successfully Updated Your Profile Picture");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  captureImageFromCamera() async {
     imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      Get.snackbar("Profile Image",
          "You Have Successfully Updated Your Profile Picture");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    Reference referanceStorage = FirebaseStorage.instance
        .ref()
        .child("profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask task = referanceStorage.putFile(imageFile);
    TaskSnapshot snapshot = await task;

    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();

    return downloadUrlOfImage;
  }

  createNewUserAccount(
    File imageProfile,
    String name,
    String email,
    String password,
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
    try {
      // 1 authenticate user,
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // 2 upload image to storage
      String urlOfDownloadedImage = await uploadImageToStorage(imageProfile);

      // 3 save user info to firestore database
      personModel.Person personInstance = personModel.Person(
        uid: FirebaseAuth.instance.currentUser!.uid,
        imageProfile: urlOfDownloadedImage,
        name: name,
        password: password,
        email: email,
        age: int.parse(age),
        phoneNo: phoneNo,
        city: city,
        country: country,
        profileHeading: profileHeading,
        lookingForInaPartner: lookingForInaPartner,
        // publishedDateTime: DateTime.now().microsecondsSinceEpoch,
        // [int microsecondsSinceEpoch],
        height: height,
        weight: weight,
        bodyType: bodyType,
        drink: drink,
        smoke: smoke,
        martialStatus: martialStatus,
        haveChildren: haveChildren,
        noOfChildren: noOfChildren,
        profession: profession,
        employmentStatus: employmentStatus,
        income: income,
        livingSituation: willingToRelocate,
        relationshipYouAreLookingFor: relationshipYouAreLookingFor,
        nationality: nationality,
        languageSpoken: languageSpoken,
        ethnicity: ethnicity,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(personInstance.toJson());
      Get.snackbar(
          "Account Created", "Congratulation! Your Account Is Created");
      Get.to(HomeScreen());
    } catch (errorMsg) {
      Get.snackbar(
          "Account Creation Unsuccessful", "Error occurred: $errorMsg");
    }
  }

  loginUser(String emailUser, String passwordUser) async{

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailUser, password: passwordUser);
      Get.snackbar("Login Successful", "😊");
      Get.to(HomeScreen());
    }
    catch(errorMsg){
      Get.snackbar("Login Error", "Error Occurred: $errorMsg");
    }
  }
  
  checkIfUserIsLoggedIn(User? currUser){
    if(currUser == null){
      Get.to(LoginScreen());
    }
    else{
      Get.to(HomeScreen());
    }
  }

  @override
  void onReady(){
    // TODO: implement onReady

    super.onReady();

    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(firebaseCurrentUser, checkIfUserIsLoggedIn);
  }
}
