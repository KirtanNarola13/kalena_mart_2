// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kalena_mart/modules/screens/address-screen/view/address_screen.dart';

import '../../../../../utils/auth-helper.dart';
import '../../../../../utils/firestore_helper.dart';
import '../../model/sign-up-model.dart';

//todo: anonymous btn click
anonymous() async {
  Map<String, dynamic> res = await AuthHelper.authHelper.signInAnonymous();
  if (res['error'] != null) {
    log("login failed");
  } else {
    log("login success");
    Get.offAllNamed('/home');
  }
}

//todo: signup btn click
signUp({required String email, required String password}) async {
  SignUpModel signUpModel = SignUpModel(email: email, password: password);
  Map<String, dynamic> res =
      await AuthHelper.authHelper.signUp(signUpModel: signUpModel);
  if (res['error'] != null) {
    log(
      'signup failed',
    );
  } else {
    log(
      'user created',
    );

    Get.to(
      const AddressScreen(),
    );
  }
}

//todo: login btn click
login(
    {required String email,
    required String password,
    required BuildContext context}) async {
  SignUpModel signUpModel = SignUpModel(email: email, password: password);
  Map<String, dynamic> res =
      await AuthHelper.authHelper.login(signUpModel: signUpModel);

  if (res['error'] != null) {
    return CherryToast.error(
      title: const Text(
        "Login Failed",
      ),
    ).show(context);
  } else {
    Get.offAllNamed(
      '/navbar',
    );
    FireStoreHelper.fireStoreHelper.addUser();
  }
}

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

google() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // User canceled the sign-in
      return;
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      Get.offAllNamed('/navbar');
      FireStoreHelper.fireStoreHelper.addUser();
    }
  } catch (e) {
    log('Google sign-in failed: $e');
    CherryToast.error(
      title: const Text("Google Sign-In Failed"),
    ).show(Get.context!);
  }
}

// google() async {
//   Map<String, dynamic> res = await AuthHelper.authHelper.signInWithGoogle();
//   if (res['error'] != null) {
//     return log('login failed');
//   } else {
//     Get.offAllNamed('/navbar');
//     FireStoreHelper.fireStoreHelper.addUser();
//   }
// }

Stack loginStack() => Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: (Get.isDarkMode == true) ? Colors.white : Colors.black,
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          color: (Get.isDarkMode == true) ? Colors.black : Colors.white,
          child: const Text("OR"),
        ),
      ],
    );

Container loginContainer(
        {required String img, required BuildContext context}) =>
    Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.sizeOf(context).height / 15,
      width: MediaQuery.sizeOf(context).height / 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (Get.isDarkMode == true)
              ? Colors.white.withOpacity(0.5)
              : Colors.black.withOpacity(0.5),
        ),
      ),
      child: Image.asset(img),
    );
