import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalena_mart/modules/screens/sign-up-screen/views/sign-up-screen.dart';

import '../controller/login-controller.dart';
import 'constant/const.dart';
import 'constant/string.dart';

// Import other dependencies and files as needed

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _talk = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    LoginController loginController = Get.put(LoginController());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h / 30,
            ),
            SafeArea(
              child: Container(
                height: h / 4.5,
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login to your',
                      style: TextStyle(
                        fontSize: 37,
                      ),
                    ),
                    Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: h / 2.8,
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Form(
                key: _talk,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: h / 35,
                      ),
                      TextFormField(
                        onSaved: (String? val) {
                          emailCon.text = val!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: emailCon,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 10,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h / 35,
                      ),
                      TextFormField(
                        onSaved: (String? val) {
                          passCon.text = val!;
                        },
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Password is too short';
                          }
                          return null;
                        },
                        controller: passCon,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              width: 10,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: h / 35,
                      ),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (_talk.currentState!.validate()) {
                            loginController.showLoading();
                            login(
                                email: emailCon.text,
                                password: passCon.text,
                                context: context);
                          } else {
                            loginController.hideLoading();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid Email or Password'),
                              ),
                            );
                          }
                        },
                        child: GetX<LoginController>(
                          builder: (controller) {
                            return Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              width: w / 1.5,
                              height: h / 13,
                              decoration: BoxDecoration(
                                color: (Get.isDarkMode == true)
                                    ? Colors.white
                                    : Colors.black,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: controller.isLoading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        (Get.isDarkMode == true)
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    )
                                  : Text('Sign In',
                                      style: TextStyle(
                                        color: (Get.isDarkMode == true)
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 22,
                                      )),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: loginStack(),
            ),
            Center(
              child: GestureDetector(
                  onTap: () {},
                  child: loginContainer(
                      img: 'assets/google.png', context: context)),
            ),
            SizedBox(
              height: h / 9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create new account ',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(SignUpScreen());
                  },
                  splashColor: Colors.black,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: h * 0.04,
                    width: w * 0.2,
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        // Change to your desired color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
