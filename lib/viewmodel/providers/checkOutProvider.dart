import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/lists.dart';

class CheckoutProvider extends ChangeNotifier{
  
String addressType = '';
  String street = '';

  Future<void> getAddress() async {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (userData.exists) {
      Map<String, dynamic> userDataMap =
          userData.data() as Map<String, dynamic>;
      addressType = userDataMap['addressType'];
      street = userDataMap['street'];
    }
    notifyListeners();
  }


//////////////////////////////////////////////////////////////////////////////////////////////////////////


 int selectedShippingType = 0;
int shippingprice=0;

  shippingPrice(index){
shippingprice=shippingPrices[index];
  }


} 