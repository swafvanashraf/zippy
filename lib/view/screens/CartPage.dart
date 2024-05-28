

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/widget/cartPageWidgets.dart';
import 'package:flutter_application_1/viewmodel/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final user = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  @override
  void initState() {
    Provider.of<CartProvider>(context, listen: false).calculateTotalPrice();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerobj = Provider.of<CartProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: height * .07,
          ),
          appbar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: StreamBuilder(
                stream: user.snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    Map<String, dynamic>? userData = snapshot.data.data();

                    if (userData != null) {
                      providerobj.cartlist = userData['cartlist'] ?? [];
                    }
                  }
                  return ListView.builder(
                    itemCount: providerobj.cartlist.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: height / 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: backgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(19),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                image(height, width, providerobj, index),
                                SizedBox(
                                  width: width * .04,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      titleAndDelete(width, providerobj, index,
                                          context, height),
                                      star(providerobj, index),
                                      priceAndQuantity(
                                          providerobj, index, height, width)
                                    ],
                                  ),
                                )
                              ]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          checkoutRow(height, providerobj, width, context)
        ],
      ),
    );
  }
}
