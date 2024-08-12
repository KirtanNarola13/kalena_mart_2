
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalena_mart/utils/firestore_helper.dart';
import 'package:kalena_mart/utils/model/cart_modal.dart';
import 'package:line_icons/line_icons.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {

    List args = ModalRoute.of(context)!.settings.arguments as List;

    Map<String, dynamic> data = {
      'image': args[0],
      'name': args[1],
      'price': args[2],
      'mrp': args[3],
      'description': args[4],
    };
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(
                  10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      "DETAIL",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/cart');
                      },
                      child: StreamBuilder(
                        stream:
                            FireStoreHelper.fireStoreHelper.fetchCartProducts(),
                        builder: (context, snapshot) {
                          QuerySnapshot<Map<String, dynamic>>? querySnapshot =
                              snapshot.data;
                          List<QueryDocumentSnapshot<Map<String, dynamic>>>
                              cartList = querySnapshot?.docs ?? [];

                          if (snapshot.hasError) {
                            return Stack(
                              alignment: const Alignment(0.5, 1.8),
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.toNamed('/cart');
                                  },
                                  icon: Icon(
                                    LineIcons.shoppingBag,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/cart');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: height / 30,
                                    width: width / 30,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      "${cartList.length}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasData) {
                            return Stack(
                              alignment: const Alignment(0.5, 1),
                              children: [
                                IconButton(
                                  splashRadius: 20,
                                  onPressed: () {
                                    Get.toNamed('/cart');
                                  },
                                  icon: Icon(
                                    LineIcons.shoppingBag,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/cart');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: height / 30,
                                    width: width / 30,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      "${cartList.length}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Stack(
                            alignment: const Alignment(0.5, 1.8),
                            children: [
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: Icon(
                                  LineIcons.shoppingBag,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: height / 30,
                                width: width / 30,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: Transform.scale(
                                  scale: 0.2,
                                  child: const CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 18,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "${data['image']}",
                    ),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(
                    color: Colors.grey.shade700,
                    width: 2,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade700,
                    width: 2,
                  ),
                  color: Colors.grey.shade200.withOpacity(
                    0.1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      20,
                    ),
                    topRight: Radius.circular(
                      20,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${data['name']}",
                            style: const TextStyle(
                              letterSpacing: 2,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${data['price']}",
                            style: const TextStyle(
                              letterSpacing: 2,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "${data['description']}",
                              style: TextStyle(
                                color: Colors.grey.shade700.withOpacity(
                                  0.8,
                                ),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              CherryToast.success(
                                title: const Text("Product Added"),
                              ).show(context);
                              CartModal cartModal = CartModal(
                                name: data['name'],
                                price: data['price'],
                                mrp: data['mrp'],
                                image: data['image'],
                                description: data['description'],
                              );
                              FireStoreHelper.fireStoreHelper
                                  .cartProduct(cartModal);
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height / 0.8,
                              width: width / 2,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                    blurStyle: BlurStyle.outer,
                                  ),
                                ],
                                color: Colors.grey.shade500.withOpacity(0.3),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: Colors.grey.shade700,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                (data['isBuy'] != true)
                                    ? "Add to cart"
                                    : "Remove",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 16,
                                  letterSpacing: 5,
                                  fontWeight: FontWeight.w500,
                                ),
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
          ],
        ),
      ),
    );
  }
}
