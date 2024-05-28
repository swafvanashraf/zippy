import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/utils/commun_widgets.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/viewmodel/providers/APIprovider.dart';
import 'package:flutter_application_1/viewmodel/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

class wishlist_page extends StatefulWidget {
  const wishlist_page({super.key});

  @override
  State<wishlist_page> createState() => _wishlist_pageState();
}

class _wishlist_pageState extends State<wishlist_page> {
  final user = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final providerobj = Provider.of<wishlistProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 228, 228),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
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
                  'My Wishlist',
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
                      providerobj.wishlist = userData['wishlist'] ?? [];
                    }
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(),
                    itemCount: providerobj.wishlist.length,
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
                                    providerobj.wishlist[index]['thumbnail'],
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
                                        providerobj.wishlist[index]['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Text(
                                      '⭐${providerobj.wishlist[index]['rating'].toString()}   |   ${providerobj.wishlist[index]['stock']} Stocks available',
                                      maxLines: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\$${providerobj.wishlist[index]['price']}',
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
                                                    .products[providerobj
                                                        .wishlist[index]['id'] -
                                                    1];
                                            Provider.of<wishlistProvider>(
                                                    context,
                                                    listen: false)
                                                .wishlistDelete(product);
                                            showToast('Product removed');
                                          },
                                          child: Container(
                                            height: height * .04,
                                            width: width * .25,
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Center(
                                              child: Text(
                                                'Remove',
                                                style: TextStyle(
                                                    // color: backgroundColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
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
            ),
          ],
        ),
      ),
    );
  }
}
