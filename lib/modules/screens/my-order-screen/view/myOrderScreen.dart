//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../utils/auth-helper.dart';
// import '../../../../utils/firestore_helper.dart';
//
// class MyOrderScreen extends StatefulWidget {
//   const MyOrderScreen({super.key});
//
//   @override
//   State<MyOrderScreen> createState() => _MyOrderScreenState();
// }
//
// class _MyOrderScreenState extends State<MyOrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.sizeOf(context).height;
//     double width = MediaQuery.sizeOf(context).width;
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         stream: FireStoreHelper.fireStoreHelper.fetchOrders(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           } else if (snapshot.hasData) {
//             List<QueryDocumentSnapshot<Map<String, dynamic>>> orders =
//                 snapshot.data!.docs;
//
//             return ListView.builder(
//               itemCount: orders.length,
//               itemBuilder: (context, index) {
//                 var order = orders[index];
//                 List<dynamic> products = order['products'];
//
//                 return (order['userId'] == AuthHelper.auth.currentUser?.uid)
//                     ? Row(
//                         children: [
//                           // Your existing image and other widgets
//                           Expanded(
//                             flex: 5,
//                             child: Container(
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Iterate over products and display their information
//                                   for (var product in products)
//                                     Container(
//                                       alignment: Alignment.center,
//                                       margin: const EdgeInsets.all(10),
//                                       height: height * 0.2,
//                                       decoration: BoxDecoration(
//                                         color: Colors.grey.shade300,
//                                         borderRadius: const BorderRadius.all(
//                                           Radius.circular(
//                                             15,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.all(20),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: const BorderRadius.all(
//                                                   Radius.circular(15),
//                                                 ),
//                                                 image: DecorationImage(
//                                                   image: NetworkImage(
//                                                       "${product['image']},"),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               alignment: Alignment.center,
//                                               margin: const EdgeInsets.all(10),
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Expanded(
//                                                     flex: 2,
//                                                     child: Text(
//                                                       product['name'],
//                                                       style: const TextStyle(
//                                                         fontSize: 14,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const Divider(),
//                                                   Expanded(
//                                                     flex: 2,
//                                                     child: Text(
//                                                       product['description'],
//                                                       style: const TextStyle(
//                                                         fontSize: 12,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const Divider(),
//                                                   Expanded(
//                                                     child: Text(
//                                                         "${product['price']}"),
//                                                   ),
//                                                   const Divider(),
//                                                   Expanded(
//                                                     child: Row(
//                                                       children: [
//                                                         const Text("Quantity : "),
//                                                         Text(
//                                                             "${product['quantity']}"),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     : const SizedBox();
//               },
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../utils/auth-helper.dart';
import '../../../../utils/firestore_helper.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Orders",
          // style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FireStoreHelper.fireStoreHelper.fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> orders =
                snapshot.data!.docs;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                List<dynamic> products = order['products'];

                return (order['userId'] == AuthHelper.auth.currentUser?.uid)
                    ? Column(
                        children: [
                          for (var product in products)
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(10),
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        image: DecorationImage(
                                          image: NetworkImage(product['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product['name'],
                                            // style: Theme.of(context)
                                            //     .textTheme
                                            //     .subtitle1,
                                          ),
                                          const Divider(),
                                          Text(
                                            product['description'],
                                            // style: Theme.of(context)
                                            //     .textTheme
                                            //     .bodyText2,
                                          ),
                                          const Divider(),
                                          Text(
                                            "${product['price']}",
                                            // style: Theme.of(context)
                                            //     .textTheme
                                            //     .bodyText1,
                                          ),
                                          const Divider(),
                                          Row(
                                            children: [
                                              const Text("Quantity: "),
                                              Text("${product['quantity']}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      )
                    : const SizedBox();
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
