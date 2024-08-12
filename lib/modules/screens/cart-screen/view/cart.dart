import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalena_mart/constants/string.dart';

import '../../../../utils/auth-helper.dart';
import '../../../../utils/firestore_helper.dart';
import '../../comformetion-screen/view/comformation-screen.dart';

class CartProduct extends StatefulWidget {
  final Map<String, dynamic> cartProduct;
  final Function(int) onQuantityChanged; // Add callback function

  const CartProduct({
    Key? key,
    required this.cartProduct,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartProduct['quantity'] ??
        1; // Initialize quantity from cart data
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      widget.onQuantityChanged(quantity); // Notify parent about quantity change
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        widget
            .onQuantityChanged(quantity); // Notify parent about quantity change
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      height: height / 5.5,
      width: width / 1.2,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.cartProduct['image'],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(widget.cartProduct['name']),
                  ),
                  Expanded(
                    child: Text("${widget.cartProduct['price']}"),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            decrementQuantity();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            height: height * 0.025,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              color: Colors.grey.shade100,
                            ),
                            child: const Icon(
                              Icons.remove,
                              size: 16,
                            ),
                          ),
                        ),
                        Text("$quantity"),
                        GestureDetector(
                          onTap: () {
                            incrementQuantity();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            height: height * 0.025,
                            width: width * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              color: Colors.grey.shade100,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 16,
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
          Expanded(
            flex: 1,
            child: Container(
              height: height * 0.05,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  FireStoreHelper.fireStoreHelper
                      .removeProductFromCart(widget.cartProduct['id']);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _cartStream;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> cart = [];

  @override
  void initState() {
    super.initState();
    _cartStream = _fetchCartProducts();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _fetchCartProducts() {
    return FireStoreHelper.fireStoreHelper.fetchCartProducts();
  }

  double calculateCartTotal(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> cart) {
    double total = 0;
    for (var item in cart) {
      double price = double.parse(item['price'].toString());
      int quantity =
          item['quantity']; // Assuming 'quantity' field exists in Firestore
      total += price * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    checkout(BuildContext context) async {
      // Your existing checkout logic
      String userId = AuthHelper.auth.currentUser!.uid;

      List<Map<String, dynamic>> cartProducts =
          cart.map((doc) => doc.data()).toList();
      await FireStoreHelper.fireStoreHelper.clearCart(userId);

      await FireStoreHelper.fireStoreHelper.createOrder(userAddress!,
          int.parse(userNumber!), userEmail!, userId, cartProducts);

      // Now you can clear the cart or navigate to the order confirmation screen
      // Clear the cart: Implement clearing logic here
      // Navigate to the order confirmation screen: Use Navigator to push a new screen

      // Push a new screen with the confirmation and checkmark GIF
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const ConfirmationScreen(), // Create ConfirmationScreen widget
        ),
      );
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
          style: GoogleFonts.raleway().copyWith(
            letterSpacing: 1.5,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _cartStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  cart = snapshot.data!.docs;
                  double totalCartPrice = calculateCartTotal(cart);

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> cartProduct = cart[index].data();
                      return CartProduct(
                        cartProduct: cartProduct,
                        onQuantityChanged: (newQuantity) {
                          setState(() {
                            // Update quantity in Firestore
                            firestore
                                .collection("users")
                                .doc(AuthHelper.auth.currentUser?.uid)
                                .collection('cart')
                                .doc(cart[index].id)
                                .update({'quantity': newQuantity});
                          });
                        },
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  height: height * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: _cartStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          cart = snapshot.data!.docs;
                          double totalCartPrice = calculateCartTotal(cart);

                          return Text(
                            'Total: $totalCartPrice', // Display total cart price
                            style: const TextStyle(
                              letterSpacing: 2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    AssetsAudioPlayer.newPlayer().open(
                      Audio("assets/sound/order-comformation-sound.mp3"),
                      autoStart: true,
                      volume: 1,
                    );
                    checkout(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          15,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Checkout", // Display total cart price
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
