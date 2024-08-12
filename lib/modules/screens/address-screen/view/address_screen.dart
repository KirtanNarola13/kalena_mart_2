import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kalena_mart/modules/screens/login-screen/view/login-screen.dart';
import 'package:kalena_mart/utils/auth-helper.dart';
import 'package:kalena_mart/utils/firestore_helper.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController moNumberController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SafeArea(
          child: Form(
            key: _addressKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.05,
                ),
                const Text(
                  'Setup your',
                  style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: h * 0.07,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (String? val) {
                            emailController.text = val!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        TextFormField(
                          onSaved: (String? val) {
                            moNumberController.text = val!;
                          },
                          validator: (value) {
                            if (value!.length < 10) {
                              return 'Phone number not valid';
                            }
                            return null;
                          },
                          controller: moNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        TextFormField(
                          onSaved: (String? val) {
                            addressController.text = val!;
                          },
                          controller: addressController,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            prefixIcon: Icon(
                              Icons.home,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.07,
                        ),
                        GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (_addressKey.currentState!.validate()) {
                              FireStoreHelper.fireStoreHelper
                                  .setupAddress(
                                    uid: AuthHelper.auth.currentUser!.uid,
                                    email: emailController.text,
                                    number: moNumberController.text,
                                    address: addressController.text,
                                  )
                                  .then(
                                    (value) => Get.to(
                                      LoginScreen(),
                                    ),
                                  );
                            }
                          },
                          child: Container(
                            width: w * 0.7,
                            height: h * 0.07,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Get.isDarkMode == true
                                  ? Colors.white
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Complete Your Account',
                              style: TextStyle(
                                color: Get.isDarkMode == true
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 19,
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
        ),
      ),
    );
  }
}
