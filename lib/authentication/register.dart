import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';
import '../mainScreens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();



  String sellerImageUrl="";


  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }



  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please Select an image",
            );
          });
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (confirmPasswordController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty ) {
          //start uploading image
          showDialog(
              context: context,
              builder: (c){
                return LoadingDialog(
                  message: "Registering Account",
                );
              }
          );
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
          fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageUrl=url;
            //save info to firestore database
            authenticateSellerAndSignUp();
          });
        } else {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorDialog(
                  message: "Please fill the required information",
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "Password do not match",
              );
            });
      }
    }
  }

  void authenticateSellerAndSignUp() async{
    User? currentUser;

    await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    ).then((auth) {
      currentUser=auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });
    if(currentUser!=null){
      saveDataToFirestore(currentUser!).then((value){
        Navigator.pop(context);
        //send user to homepage
        Route newRoute = MaterialPageRoute(builder: (c)=>HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async{
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "uid": currentUser.uid,
      "email":currentUser.email,
      "name": nameController.text.trim(),
      "photoUrl": sellerImageUrl,
      "status":"approved",
      "userCart": ["garbageValue"]

    });

    //save data locally
     sharedPreferences= await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", sellerImageUrl);
    await sharedPreferences!.setStringList("userCart", ["garbageValue"]);


  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
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
                key: _formKey,
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
                      controller: confirmPasswordController,
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
              child: const Text(
                "Sign Up",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.cyanAccent,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10)),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
