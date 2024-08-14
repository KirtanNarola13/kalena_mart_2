import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalena_mart/modules/screens/address-screen/view/const/address_const.dart';
import 'package:kalena_mart/utils/firestore_helper.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/auth-helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    logout() {
      AuthHelper.authHelper.signOut();
      Get.toNamed('/login');
    }

    void _showChangePhoneNumberDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit Phone Number"),
            content: Container(
              height: height * 0.3,
              child: Column(
                children: [
                  TextFormField(
                    controller: moNumberController,
                    decoration: const InputDecoration(
                      labelText: 'New Phone Number',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // _updatePhoneNumber(phoneNumberController.text);
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text("Update"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    void _showChangeAddressDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit Address"),
            content: Container(
              height: height * 0.3,
              child: Column(
                children: [
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: 'New Address',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      FireStoreHelper.fireStoreHelper
                          .changeAddress(address: addressController.text)
                          .then(
                            (value) =>
                                FireStoreHelper.fireStoreHelper.fetchAddress(),
                          );
                      setState(() {});
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text("Update"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return StreamBuilder(
        stream: FireStoreHelper.fireStoreHelper.fetchUserDetail(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;
            Map<String, dynamic> user = data?.data() ?? {};
            String userAddress = user['address'] ?? '';
            String userEmail = user['email'] ?? '';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/bg_avatar.png'),
                      fit: BoxFit.cover,
                    )),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Profile",
                                  style: GoogleFonts.raleway().copyWith(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Container(
                                  width: width * 0.10,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      logout();
                                    },
                                    icon:
                                        const Icon(LineIcons.alternateSignOut),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 6,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: (AuthHelper
                                              .auth.currentUser?.photoURL ==
                                          null)
                                      ? const NetworkImage(
                                          "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=")
                                      : NetworkImage(
                                          "${AuthHelper.auth.currentUser?.photoURL}"),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Text(
                                      user['name'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.grey.shade500.withOpacity(0.3),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Account Overview",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(10),
                            height: height * 0.09,
                            width: width / 1.1,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: const Icon(
                                      LineIcons.identificationCard,
                                      size: 35,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 5, bottom: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            "Email",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "$userEmail",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(10),
                            height: height * 0.13,
                            width: width / 1.1,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: const Icon(
                                      LineIcons.home,
                                      size: 35,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 5, bottom: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Address",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  letterSpacing: 1.5,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  _showChangeAddressDialog();
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: height * 0.3,
                                            child: Text(
                                              "${userAddress}",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(10),
                            height: height * 0.13,
                            width: width / 1.1,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: const Icon(
                                      LineIcons.whatSApp,
                                      size: 35,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 5, bottom: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            "+91 79841 80938",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: height * 0.3,
                                            child: TextButton(
                                              onPressed: () {
                                                launchUrl(
                                                  Uri(
                                                    scheme: "https",
                                                    path: "wa.me/+917984180938",
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "contact",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Note : In case mrp change , disscount will be same apply",
                                          style: TextStyle(fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
