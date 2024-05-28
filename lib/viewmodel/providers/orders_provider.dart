import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/utils/commun_widgets.dart';


class OrdersProvider extends ChangeNotifier {
  List<dynamic> orderlist = [];

  late Product product;

  String paymentID = '';
  String orderID = '';
  final user = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  ordersToFirestore(context) async {
    final total = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final userData = await total.get();

    if (!userData.exists) {
      total.set({'cartlist': [], 'wishlist': [], 'orderlist': []});
    } else {
      Map<String, dynamic>? userDataMap =
          userData.data() as Map<String, dynamic>?;

      List<dynamic>? cartlist =
          List.from(userDataMap?['cartlist'] as List<dynamic>);

      final data = {
        'orderlist': FieldValue.arrayUnion(cartlist),
        'cartlist': [],
      };

      user.update(data);
      showToast('Orders successfull');
    }
    notifyListeners();
  }

//////////////////////////////////////////////////////////////////////////

  int selectedindex = 0;

  // orderToFirestore() async {
  //   final total = FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(FirebaseAuth.instance.currentUser?.uid);
  //   final users = await total.get();

  //   if (!users.exists) {
  //     total.set({'cartlist': [], 'wishlist': [], 'orderlist': []});
  //   }
  //   final data = {
  //     'orderlist': FieldValue.arrayUnion([
  //       {
  //         'brand':product.brand,
  //         'id': product.id,
  //         'thumbnail': product.thumbnail,
  //         'price': product.price,
  //         'discription': product.description,
  //         'discountPercentage':
  //             product.discountPercentage,
  //         'rating': product.rating,
  //         'title': product.title,
  //         'stock': product.stock,
  //       }
  //     ]),
  //   };

  //   DocumentSnapshot userdata = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .get();
  //   if (userdata.exists) {
  //     Map<String, dynamic>? userDataMap =
  //         userdata.data() as Map<String, dynamic>?;

  //     final orderlist = List.from(userDataMap?['orderlist'] as List<dynamic>);
  //     bool productAlreadyInOrderlist = orderlist
  //         .any((item) => item['id'] == product.id);
  //     if (!productAlreadyInOrderlist) {
  //       user.update(data);
  //       showToast('Order Successful');
  //     } else {
  //       // showToast('Product is already in the Cart');
  //     }
  //   } else {
  //     user.set({'orderlist': []});
  //   }

  //   notifyListeners();
  // }

  //////////////////////////////////////////////////////////////////
}
