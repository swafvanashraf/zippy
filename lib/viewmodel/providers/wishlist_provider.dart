import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class wishlistProvider extends ChangeNotifier {
  List<dynamic> wishlist = [];

//    int selectedindex = 0;

//   findIndex(index) {
//     selectedindex = index;
//     notifyListeners();
//   }

  final user = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  wishlistToFirestore(product) async {
    final total = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final users = await total.get();

    if (!users.exists) {
      total.set({'cartlist': [], 'wishlist': [], 'orderlist': []});
    }
    final data = {
      'wishlist': FieldValue.arrayUnion([
        {
          'brand': product.brand,
          'id': product.id,
          'thumbnail': product.thumbnail,
          'price': product.price,
          'discription': product.description,
          'discountPercentage': product.discountPercentage,
          'rating': product.rating,
          'title': product.title,
          'stock': product.stock,
          'isfavorite': true
        }
      ]),
    };

    DocumentSnapshot userdata = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (userdata.exists) {
      Map<String, dynamic>? userDataMap =
          userdata.data() as Map<String, dynamic>?;

      List<dynamic>? wishlist =
          List.from(userDataMap?['wishlist'] as List<dynamic>);

      bool productAlreadyInwishlist =
          wishlist.any((item) => item['id'] == product.id);
      if (!productAlreadyInwishlist) {
        user.update(data);
        print('product added');
      } else {
        wishlistDelete(product);
      }
    } else {
      user.set({'wishlist': []});
    }

    notifyListeners();
  }

// //////////////////////////////////////////////////////////////////////////////////////////////
  wishlistDelete(product) async {
    final total = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    DocumentSnapshot userdata = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    Map<String, dynamic>? userDataMap =
        userdata.data() as Map<String, dynamic>?;

    List<dynamic>? wishlist =
        List.from(userDataMap?['wishlist'] as List<dynamic>);
    int index = wishlist.indexWhere((item) => item['id'] == product.id);
    wishlist.removeAt(index);
    total.update({'wishlist': wishlist});
    print('removed');
  }

// //////////////////////////////////////////////////////////////////////////////////////////

  List<dynamic> wishlistId = [];
  getWishlistId() async {
    DocumentSnapshot userdata = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    Map<String, dynamic>? userDataMap =
        userdata.data() as Map<String, dynamic>?;

    List<dynamic>? wishlist =
        List.from(userDataMap?['wishlist'] as List<dynamic>);
    wishlistId = wishlist.map((item) => item['id']).toList();
  }

  addOrRemove(product, isInWishlist) {
    if (isInWishlist == true) {
      wishlistId.remove(product.id);
    } else {
      wishlistId.add(product.id);
    }
    notifyListeners();
  }
}
