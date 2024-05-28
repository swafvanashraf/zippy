import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/commun_widgets.dart';

class CartProvider extends ChangeNotifier {
  List<dynamic> cartlist = [];
  int totalPrice = 0;
  bool isTappedCart = false;

  int itemCount = 0;
  Future<void> getCartListLength() async {
    DocumentSnapshot userdata = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (userdata.exists) {
      Map<String, dynamic>? userDataMap =
          userdata.data() as Map<String, dynamic>?;

      List<dynamic>? cartlist = userDataMap?['cartlist'] != null
          ? List.from(userDataMap?['cartlist'] as List<dynamic>)
          : null;

      // Update the cartListLength variable with the length of cartlist
      itemCount = cartlist?.length ?? 0;
    }
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////////////////////
  final user = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  cartToFirestore(product) async {
    final total = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final users = await total.get();

    if (!users.exists) {
      total.set({
        'cartlist': [],
        'wishlist': [],
        'orderlist': [],
        'firstName': '',
        'lastName': '',
        'phoneNumber': '',
        'E-mail': '',
        'street': '',
        'apt': '',
        'addressType':'',
        'city': '',
        'state': '',
        'zipCode': ''
      });
    }
    final data = {
      'cartlist': FieldValue.arrayUnion([
        {
          'quantity': 1,
          'brand': product.brand,
          'id': product.id,
          'thumbnail': product.thumbnail,
          'price': product.price,
          'discription': product.description,
          'discountPercentage': product.discountPercentage,
          'rating': product.rating,
          'title': product.title,
          'stock': product.stock,
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

      final cartlist = List.from(userDataMap?['cartlist'] as List<dynamic>);
      bool productAlreadyInCartlist =
          cartlist.any((item) => item['id'] == product.id);
      if (!productAlreadyInCartlist) {
        user.update(data);
        showToast('Product added');
      } else {
        showToast('Product already in Cart');
      }
    } else {
      user.set({'cartlist': []});
    }

    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////

  Future<int> calculateTotalPrice() async {
    DocumentSnapshot userdata = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    totalPrice = 0;
    if (userdata.exists) {
      Map<String, dynamic>? userDataMap =
          userdata.data() as Map<String, dynamic>?;

      if (userDataMap != null &&
          userDataMap.containsKey('cartlist') &&
          userDataMap['cartlist'] is List<dynamic>) {
        List<dynamic> cartlist = userDataMap['cartlist'];
        for (var item in cartlist) {
          totalPrice += (item['price'] * item['quantity'] as num).toInt();
        }
      }
    }
    notifyListeners();
    return totalPrice;
  }

/////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> decrementPrice(int itemIndex) async {
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    DocumentSnapshot userdata = await userDocRef.get();

    if (userdata.exists) {
      Map<String, dynamic>? userDataMap =
          userdata.data() as Map<String, dynamic>?;

      List<dynamic>? cartlist =
          List.from(userDataMap?['cartlist'] as List<dynamic>);

      if (itemIndex >= 0 && itemIndex < cartlist.length) {
        totalPrice -= (cartlist[itemIndex]['price'] as num).toInt();

        cartlist.removeAt(itemIndex);

        await userDocRef.update({'cartlist': cartlist});
      }
    }
    calculateTotalPrice();
    notifyListeners();
  }

//////////////////////////////////////////////////////////////////////////////////////

  quantityPrice(index) async {
    DocumentReference userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    DocumentSnapshot userdata = await userData.get();

    if (userdata.exists) {
      Map<String, dynamic>? userDataMap =
          userdata.data() as Map<String, dynamic>?;

      List<dynamic>? cartlist =
          List.from(userDataMap?['cartlist'] as List<dynamic>);

      cartlist[index]['quantity'] = quantity;
      final data = {'cartlist': cartlist};
      user.update(data);
      totalPrice = 0;
      for (var item in cartlist) {
        totalPrice += (item['price'] * item['quantity'] as num).toInt();
        // totalPrice = (totalPrice * item['quantity']).toInt();
      }
      // totalPrice = totalPrice +
      //     ((cartlist[index]['price']) * (newQuantity - 1) as num).toInt();
    }
    notifyListeners();
  }
  //////////////////////////////////////////////////////////////////////////////////

  int quantity = 1;
  itemCountIncrease(index) async {
    DocumentReference userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    DocumentSnapshot userdata = await userData.get();

    if (userdata.exists) {
      Map<String, dynamic>? userDataMap =
          userdata.data() as Map<String, dynamic>?;

      List<dynamic>? cartlist =
          List.from(userDataMap?['cartlist'] as List<dynamic>);

      if (cartlist[index]['quantity'] == 9) {
        showToast('Maximum quantity is 9');
      } else {
        quantity = cartlist[index]['quantity'] + 1;
        quantityPrice(index);
      }
      notifyListeners();
    }
  }

  itemCountDecreas(index) async {
    DocumentReference userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    DocumentSnapshot userdata = await userData.get();

    if (userdata.exists) {
      Map<String, dynamic>? userDataMap =
          userdata.data() as Map<String, dynamic>?;

      List<dynamic>? cartlist =
          List.from(userDataMap?['cartlist'] as List<dynamic>);
      if (cartlist[index]['quantity'] == 1) {
        showToast('Minimum quantity is 1');
      } else {
        quantity = cartlist[index]['quantity'] - 1;
        quantityPrice(index);
      }
      notifyListeners();
    }
  }

  totalPriceToZero() {
    totalPrice = 0;
    notifyListeners();
  }
}
