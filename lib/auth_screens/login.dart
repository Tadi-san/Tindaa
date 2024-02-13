import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tindaa/auth_screens/registeration_screen.dart';
import 'package:tindaa/controllers/authentication_controllers.dart';
import 'package:tindaa/widgets/custom_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showProgressBar = false;
  var controlerAuth = AuthenticationController.authController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
          const CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage("images/react.png"),
            backgroundColor: Colors.black,
          ),
              const SizedBox(
                height: 10,
              ),
             const Text(
                "Wellcome",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Login now to find your spouse",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width -10,
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
              SizedBox(
                width: MediaQuery.of(context).size.width -10,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: passwordTextEditingController,
                  lableText: "Password",
                  iconData: Icons.lock_outline,
                  isObscure: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // Login Button
              Container(
                width: MediaQuery.of(context).size.width -10,
                height: 55,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12)
                  )
                ),
                child: InkWell(
                  onTap: () async{
                  if(emailTextEditingController.text.trim().isNotEmpty && passwordTextEditingController.text.trim().isNotEmpty){
                    setState(() {
                      showProgressBar = true;
                    });

                    await controlerAuth.loginUser(emailTextEditingController.text.trim(),
                          passwordTextEditingController.text.trim());

                    setState(() {
                      showProgressBar = false;
                    });
                  }
                  else{
                    Get.snackbar("Field error", "Fill Both Fields ");
                  }
                  },
                  child: const Center(
                    child: Text(
                        "Login",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )

                    )
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account yet? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Get.to(const RegistratinScreen());
                    },
                    child: const Text(
                      "Create Here",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent
                      ),
                    ),
                  )

                ],
              ),
              const SizedBox(
                height: 15,
              ),
              showProgressBar == true
                  ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
              )
                  : Container(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
