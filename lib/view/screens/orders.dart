

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/utils/commun_widgets.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/screens/TrackOrder.dart';

import 'package:flutter_application_1/viewmodel/providers/APIprovider.dart';
import 'package:flutter_application_1/viewmodel/providers/orders_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final user = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final providerobj = Provider.of<OrdersProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 228, 228),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .07,
            ),
            Row(
              children: [
                logo(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'My Orders',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ],
            ),
            SizedBox(
              height: height * .035,
            ),
            Expanded(
              child: StreamBuilder(
                stream: user.snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    Map<String, dynamic>? userData = snapshot.data.data();

                    if (userData != null) {
                      providerobj.orderlist = userData['orderlist'] ?? [];
                    }
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(),
                    itemCount: providerobj.orderlist.length,
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
                              Container(
                                height: height / 3,
                                width: width / 4,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: primaryColor, width: 1)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    providerobj.orderlist[index]['thumbnail'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * .04,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width / 3.5,
                                      child: Text(
                                        providerobj.orderlist[index]['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: providerobj
                                              .orderlist[index]['rating'],
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 15,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text(
                                            '  |  Qty =${providerobj.orderlist[index]['quantity'].toString()}')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\$${providerobj.orderlist[index]['price']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Product product =
                                                Provider.of<APIprovider>(
                                                            context,
                                                            listen: false)
                                                        .fetchData
                                                        .products[
                                                    providerobj.orderlist[index]
                                                            ['id'] -
                                                        1];

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TrackOrder(
                                                            product: product,
                                                            Quantity: providerobj
                                                                        .orderlist[
                                                                    index]
                                                                ['quantity'])));
                                          },
                                          child: Container(
                                            height: height * .045,
                                            width: width * .30,
                                            decoration: BoxDecoration(
                                                color: accentColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Center(
                                              child: Text(
                                                'Track Order',
                                                style: TextStyle(
                                                    color: backgroundColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
