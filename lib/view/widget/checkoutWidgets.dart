import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/screens/addressPage.dart';
import 'package:flutter_application_1/view/screens/bottomNavigationbar.dart';
import 'package:flutter_application_1/view/screens/shippingType.dart';
import 'package:flutter_application_1/view/widget/cartPageWidgets.dart';
import 'package:flutter_application_1/viewmodel/providers/cart_provider.dart';
import 'package:flutter_application_1/viewmodel/providers/checkOutProvider.dart';
import 'package:provider/provider.dart';

Row title(context) {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context,
              MaterialPageRoute(builder: (context) => bottumNavigationbar()));
        },
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        'Checkout',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
      ),
    ],
  );
}

//////////////////////////////////////////////////////////////////////////////////////

Container productTitle(double width, CartProvider providerobj, int index) {
  return Container(
    width: width / 3.5,
    child: Text(
      providerobj.cartlist[index]['title'],
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

Row priceAndCount(
    CartProvider providerobj, int index, double height, double width) {
  return Row(
    children: [
      Text(
        '\$${providerobj.cartlist[index]['price']}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Spacer(),
      Container(
        height: height * .05,
        width: width * .15,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            providerobj.cartlist[index]['quantity'].toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      )
    ],
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

Padding addressContainer(
    double height, double width, context, addressType, street) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 12),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      height: height * .11,
      child: Padding(
        padding: const EdgeInsets.only(left: 17, right: 13),
        child: Row(children: [
          CircleAvatar(
            radius: 29,
            backgroundColor: primaryColor,
            child: CircleAvatar(
              backgroundColor: accentColor,
              child: Icon(
                Icons.location_on,
                color: backgroundColor,
              ),
            ),
          ),
          SizedBox(
            width: width * .03,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                addressType,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                street,
                maxLines: 1,
                style: TextStyle(fontSize: 16, color: secondarytextColor),
              ),
            ],
          ),
          Spacer(),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddressPage()));
              },
              icon: Icon(Icons.edit))
        ]),
      ),
    ),
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ListView cartProducts(CartProvider providerobj, double height, double width) {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(),
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
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            image(height, width, providerobj, index),
            SizedBox(
              width: width * .04,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  productTitle(width, providerobj, index),
                  star(providerobj, index),
                  priceAndCount(providerobj, index, height, width)
                ],
              ),
            )
          ]),
        ),
      );
    },
  );
}

/////////////////////////////////////////////////////////////////////////////////////////////////

Container shippingTypeContainer(double height, double width, context) {
  return Container(
    height: height * .08,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: backgroundColor),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(
        children: [
          Image.asset(
            'asset/truck.png',
            scale: width * .025,
          ),
          SizedBox(
            width: width * .04,
          ),
          Text(
            'Choose Shipping Type',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Spacer(),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShippingType()));
              },
              icon: Icon(Icons.arrow_forward_ios_sharp))
        ],
      ),
    ),
  );
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

Container priceContainer(double height, BuildContext context, shippingCost) {
  return Container(
    height: height * .22,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: backgroundColor),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(35, 25, 35, 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: TextStyle(color: secondaryColor),
              ),
              Text(
                '\$${Provider.of<CartProvider>(context).totalPrice}.00',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping',
                style: TextStyle(color: secondaryColor),
              ),
              Text(
                shippingCost == 0 ? '________' : '\$${shippingCost}.00',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(color: secondaryColor),
              ),
              Text(
                '\$${Provider.of<CartProvider>(context).totalPrice + shippingCost}.00',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          )
        ],
      ),
    ),
  );
}
