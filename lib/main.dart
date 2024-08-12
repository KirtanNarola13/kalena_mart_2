import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalena_mart/modules/screens/cart-screen/view/cart.dart';
import 'package:kalena_mart/modules/screens/detail_screen.dart';
import 'package:kalena_mart/modules/screens/home-screen/view/home_page.dart';
import 'package:kalena_mart/modules/screens/navbar/navbar.dart';
import 'package:kalena_mart/modules/screens/sign-up-screen/views/sign-up-screen.dart';

import 'firebase_options.dart';
import 'modules/screens/login-screen/view/login-screen.dart';
import 'modules/screens/splash-screen/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(

    GetMaterialApp(
      theme: ThemeData(
          useMaterial3: true, textTheme: GoogleFonts.openSansTextTheme()),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        // GetPage(
        //   name: '/',
        //   page: () => IntroScreen(),
        // ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignUpScreen(),
        ),
        GetPage(
          name: '/navbar',
          page: () => const NavBar(),
        ),

        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/detail',
          page: () => const DetailPage(),
        ),
        GetPage(
          name: '/cart',
          page: () => const CartScreen(),
        ),
      ],
    ),
  );
}
