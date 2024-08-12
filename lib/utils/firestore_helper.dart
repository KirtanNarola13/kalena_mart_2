import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kalena_mart/utils/model/cart_modal.dart';
import 'auth-helper.dart';

class FireStoreHelper {
  // Singleton pattern
  FireStoreHelper._();
  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Add User
  Future<void> addUser() async {
    log("Execute");
    await firestore
        .collection("users")
        .doc(AuthHelper.auth.currentUser?.uid)
        .set({
      'name': (AuthHelper.auth.currentUser?.displayName == null)
          ? "${AuthHelper.auth.currentUser?.email?.split("@")[0].capitalizeFirst}"
          : "${AuthHelper.auth.currentUser?.displayName}",
      'email': "${AuthHelper.auth.currentUser?.email}",
      'uid': "${AuthHelper.auth.currentUser?.uid}",
      'dp': (AuthHelper.auth.currentUser?.photoURL == null)
          ? "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png"
          : AuthHelper.auth.currentUser?.photoURL,
    });
    log(
      "User Added",
    );
  }

  Future<void> setupAddress(
      {required String uid,
      required String email,
      required String number,
      required String address}) async {
    return firestore
        .collection("addresses")
        .doc(AuthHelper.auth.currentUser?.uid)
        .set(
      {
        'email': "${AuthHelper.auth.currentUser?.email}",
        'uid': "${AuthHelper.auth.currentUser?.uid}",
        'number': number,
        'address': address,
      },
    );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchUserDetail() {
    return firestore
        .collection("users")
        .doc(AuthHelper.auth.currentUser?.uid)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchAddress() {
    return firestore
        .collection("addresses")
        .doc(AuthHelper.auth.currentUser?.uid)
        .snapshots();
  }
  //   Stream<QuerySnapshot<Map<String, dynamic>>> fetchOrders() {
  //   return firestore.collection('orders').snapshots();
  // }

  Future<void> cartProduct(CartModal cartModal) async {
    try {
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection("users")
          .doc(AuthHelper.auth.currentUser?.uid)
          .collection('cart')
          .add({
        'id': '', // Placeholder for doc ID
        'name': cartModal.name,
        'price': cartModal.price,
        'mrp': cartModal.mrp,
        'image': cartModal.image,
        'description': cartModal.description,
        'quantity': 1
      });

      // Update the 'id' field with the doc ID
      await documentReference.update({'id': documentReference.id});

      log("Product added to cart with ID: ${documentReference.id}");
    } catch (e) {
      log("Error adding product to cart: $e");
    }
  }

  Future<void> removeProductFromCart(String productId) async {
    try {
      // Get a reference to the product document using the provided product ID
      DocumentReference productReference = FirebaseFirestore.instance
          .collection("users")
          .doc(AuthHelper.auth.currentUser?.uid)
          .collection('cart')
          .doc(productId);

      // Delete the product document
      await productReference.delete();

      log("Product removed from cart with ID: $productId");
    } catch (e) {
      log("Error removing product from cart: $e");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCartProducts() {
    return firestore
        .collection("users")
        .doc(AuthHelper.auth.currentUser?.uid)
        .collection('cart')
        .snapshots();
  }

  Future<void> clearCart(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> cartSnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      WriteBatch batch = firestore.batch();
      for (var doc in cartSnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (error) {
      if (kDebugMode) {
        print("Error clearing cart: $error");
      }
      rethrow;
    }
  }

  Future<void> createOrder(String address, int number, String email,

      String userId, List<Map<String, dynamic>> cartProducts) async {
    CollectionReference orders = FirebaseFirestore.instance.collection('orders');

    await orders.add(
      {
        'address': address,
        'number': number,
        'email': email,
        'userId': userId,
        'products': cartProducts,
        'name': "${AuthHelper.auth.currentUser?.email!.split("@")[0].capitalize!}"
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchOrders() {
    return FirebaseFirestore.instance.collection('orders').snapshots();
  }

  // Future<void> createOrder(String address, int number, String email, String userId, List<Map<String, dynamic>> cartProducts) async {
  //   CollectionReference orders = firestore.collection('orders');
  //   await orders.add({
  //     'address': address,
  //     'number': number,
  //     'email': email,
  //     'userId': userId,
  //     'products': cartProducts,
  //     'name': "${AuthHelper.auth.currentUser?.email?.split("@")[0].capitalizeFirst}"
  //   });
  // }

  Future<void> changeAddress({required String address}) async {
    await firestore
        .collection("addresses")
        .doc(AuthHelper.auth.currentUser?.uid)
        .update({
      'address': address,
    });
  }
}
