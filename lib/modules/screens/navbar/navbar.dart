import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalena_mart/modules/screens/cart-screen/view/cart.dart';
import 'package:kalena_mart/modules/screens/favorite-screen/view/favorite.dart';
import 'package:kalena_mart/modules/screens/home-screen/view/home_page.dart';
import 'package:kalena_mart/modules/screens/profile-screen/view/profile.dart';

import '../my-order-screen/view/myOrderScreen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final controller = NavigationController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: h / 13,
        elevation: 0,
        selectedIndex: controller.selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            controller.selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Iconsax.shopping_cart), label: 'Cart'),
          NavigationDestination(
              icon: Icon(Iconsax.shopping_bag), label: 'Order'),
          NavigationDestination(
              icon: Icon(Iconsax.personalcard), label: 'Profile'),
        ],
      ),
      body: controller.screens[controller.selectedIndex],
    );
  }
}

class NavigationController {
  int selectedIndex = 0;

  final screens = <Widget>[
    const HomePage(),
    CartScreen(),
    MyOrderScreen(),
    ProfileScreen(),
  ];
}
