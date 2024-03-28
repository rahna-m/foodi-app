import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodii_users_app/global/global.dart';
import 'package:foodii_users_app/mainScreens/home_screen.dart';
import 'package:foodii_users_app/widgets/custom_text_field.dart';
import 'package:foodii_users_app/widgets/error_dialog.dart';
import 'package:foodii_users_app/widgets/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfirmpasswordController = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String userImageUrl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }


  

  Future<void> formValidation() async {
    if(imageXFile == null) {
      showDialog(context: context, builder: (c){
        return ErrorDialog(
          message: "Please select an image.",
        );
      } );
    } else {
      if(passwordController.text == ConfirmpasswordController.text) {
       

        if(ConfirmpasswordController.text.isNotEmpty && emailController.text.isNotEmpty && nameController.text.isNotEmpty){
             //  start uploading image

             showDialog(context: context, builder: (c){
              return LoadingDialog(
                message: "Registering Account",
              );
             });

             String fileName = DateTime.now().microsecondsSinceEpoch.toString();
             fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
             fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path),  fStorage.SettableMetadata(contentType: 'image/png'));
             fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
             await taskSnapshot.ref.getDownloadURL().then((url) {
              userImageUrl = url;

              print("img url : $userImageUrl");



              // save info to firestore db

              authenticateuserAndSignUp();
             });

        } else {
          showDialog(context: context, builder: (c){
          return ErrorDialog(
          message: "please fill all the fields.",);
        });
        }
      } else {
        showDialog(context: context, builder: (c){
          return ErrorDialog(
          message: "Password do not match.",);
        });
      }
    }
  }

  void authenticateuserAndSignUp() async {

    User? currentUser;
    await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((auth) {
      currentUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);

      showDialog(context: context, builder: (c){
          return ErrorDialog(
          message: error.message.toString());
        });

    });

    if(currentUser != null) {
      saveDataFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        // send user to homepage

        Route newRoute = MaterialPageRoute(builder: (c) => const HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataFirestore(User currentUser) async {

    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "uid" : currentUser.uid,
      "email" : currentUser.email,
      "name" : nameController.text.trim(),
      "photoUrl" : userImageUrl,
      "status" : "approved",
      "earnings" : 0.0,
    });
        //   save data locally

        sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!.setString("email", currentUser.email.toString());
        await sharedPreferences!.setString("name", nameController.text.trim());
        await sharedPreferences!.setString("photoUrl", userImageUrl);
        await sharedPreferences!.setStringList("userCart", ['garbageValue']);


  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile == null
                    ? null
                    : FileImage(File(imageXFile!.path)),
                child: imageXFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: MediaQuery.of(context).size.width * 0.20,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    CustomTextField(
                      data: Icons.person,
                      controller: nameController,
                      hintText: "Name",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      data: Icons.email,
                      controller: emailController,
                      hintText: "Email",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      data: Icons.lock,
                      controller: passwordController,
                      hintText: "Password",
                      isObsecre: true,
                    ),
                     CustomTextField(
                      data: Icons.lock,
                      controller: ConfirmpasswordController,
                      hintText: "Confirm Password",
                      isObsecre: true,
                    ),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                formValidation();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              child: const Text(
                "Sign Up",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
