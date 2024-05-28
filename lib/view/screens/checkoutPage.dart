import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/commun_widgets.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/widget/checkoutWidgets.dart';
import 'package:flutter_application_1/viewmodel/providers/cart_provider.dart';
import 'package:flutter_application_1/viewmodel/providers/checkOutProvider.dart';
import 'package:flutter_application_1/viewmodel/rozerpay.dart';
import 'package:provider/provider.dart';

class checkout extends StatefulWidget {
  const checkout({super.key});

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  final user = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  rozerpay rozerpayinstance = rozerpay();

  @override
  void initState() {
    rozerpayinstance.handles(context);
    Provider.of<CheckoutProvider>(context, listen: false).getAddress();

    Provider.of<CartProvider>(context, listen: false).calculateTotalPrice();
    super.initState();
  }

  @override
  void dispose() {
    rozerpayinstance.getRazorpay().clear();

    super.dispose();
  }

  Widget build(BuildContext context) {
    print('object');
    final providerobj = Provider.of<CartProvider>(context);
    final checkoutProviderobj = Provider.of<CheckoutProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 228, 228),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .07,
              ),
              title(context),
              SizedBox(
                height: height * .035,
              ),
              Text(
                'Shipping Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              addressContainer(height, width, context,
                  checkoutProviderobj.addressType, checkoutProviderobj.street),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 20),
                child: Text(
                  'Order List',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              cartProducts(providerobj, height, width),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 20),
                child: Text(
                  'Choose Shipping',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              shippingTypeContainer(height, width, context),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Divider(),
              ),
              priceContainer(
                  height, context, checkoutProviderobj.shippingprice),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    if (checkoutProviderobj.street == '' &&
                        checkoutProviderobj.shippingprice == 0) {
                      showToast('Select Address and Shipping type');
                    } else if (checkoutProviderobj.street == '') {
                      showToast('Select your Address');
                    } else if (checkoutProviderobj.shippingprice == 0) {
                      showToast('Select the Shipping type');
                    } else {
                      int payingAmount = providerobj.totalPrice +
                          checkoutProviderobj.shippingprice;
                      rozerpayinstance.createOrder(context, payingAmount);
                    }
                  },
                  child: Container(
                    height: height * .08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: accentColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue to Payment',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: width * .02,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
