import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../utils/globle.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: favList
              .map(
                (e) => Container(
                  height: height / 5,
                  width: width / 0.9,
                  margin: const EdgeInsets.only(top: 30, left: 20, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      )),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage("${e['thumbnail']}"),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10, bottom: 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "${e['name']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "₹ ${e['price']}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height / 80,
                              ),
                              Text(
                                "(${e['ratingcount']})",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 9,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${e['faceprice']}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 120,
                                  ),
                                  Text(
                                    "(%${e['discount']} off)",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height / 50,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        'detail_page',
                                        arguments: e,
                                      );
                                      setState(() {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: height / 30,
                                      width: width / 4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        "VIEW",
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 12,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      e['isLike'] = !e['isLike'];
                                      favList.remove(e);
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: height / 30,
                                      width: width / 8,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: (e['isLike'] == false)
                                          ? const Icon(
                                              LineIcons.heart,
                                              size: 16,
                                            )
                                          : Icon(
                                              Icons.favorite,
                                              color: Colors.red.withOpacity(
                                                0.5,
                                              ),
                                              size: 16,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
