import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tindaa/controllers/authentication_controllers.dart';
import 'package:tindaa/widgets/custom_text_field_widget.dart';

class RegistratinScreen extends StatefulWidget {
  const RegistratinScreen({super.key});

  @override
  State<RegistratinScreen> createState() => _RegistratinScreenState();
}

class _RegistratinScreenState extends State<RegistratinScreen> {
  // personal info
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
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

  bool showProgressBar = false;

  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            const Text(
              "to get started now",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            authenticationController.imageFile == null ?
            const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("images/mongo.png"),
                    backgroundColor: Colors.black,
                  )
                : Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(File(
                          authenticationController.imageFile!.path,
                        )),
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      await authenticationController.pickImageFromGallery();

                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: const Icon(
                      Icons.image_outlined,
                      color: Colors.grey,
                      size: 30,
                    )),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () async {
                      await authenticationController.captureImageFromCamera();

                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                      size: 30,
                    ))
              ],
            ),

// personal info
            const SizedBox(
              height: 30,
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
              width: MediaQuery.of(context).size.width - 10,
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
                editingController: emailTextEditingController,
                lableText: "Email",
                iconData: Icons.email_outlined,
                isObscure: false,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //Password
            SizedBox(
              width: MediaQuery.of(context).size.width - 10,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: passwordTextEditingController,
                lableText: "Password",
                iconData: Icons.lock_outline,
                isObscure: true,
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
                  if (authenticationController.imageFile != null) {
                    if (authenticationController.imageFile != null
                    // nameTextEditingController.text.trim().isNotEmpty &&
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
                      await authenticationController.createNewUserAccount(
                        authenticationController.ProfileImage!,
                        nameTextEditingController.text.trim(),
                        emailTextEditingController.text.trim(),
                        passwordTextEditingController.text.trim(),
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

                      );
                      setState(() {
                        showProgressBar = false;
                        // authenticationController.imageFile = null;
                      });
                    } else {
                      Get.snackbar(
                          "Field is empty", "please fill all fields in text");
                    }
                  } else {
                    Get.snackbar("Image File Missing",
                        "please pick image from gallery or capture a profile picture");
                  }
                },
                child: const Center(
                    child: Text("Register",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Text(
                    "Login Here",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            showProgressBar == true
                ? const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                  )
                : Container(),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    ));
  }
}
