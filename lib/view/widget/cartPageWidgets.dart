import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/commun_widgets.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/screens/checkoutPage.dart';
import 'package:flutter_application_1/view/widget/productDetailWidgets.dart';
import 'package:flutter_application_1/viewmodel/providers/cart_provider.dart';
import 'package:flutter_application_1/viewmodel/rozerpay.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

Padding appbar() {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20),
    child: Row(
      children: [
        logo(),
        SizedBox(
          width: 10,
        ),
        Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
      ],
    ),
  );
}

//////////////////////////////////////////////////////////////////////////////////////

Container image(
    double height, double width, CartProvider providerobj, int index) {
  return Container(
    height: height / 3,
    width: width / 4,
    decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryColor, width: 1)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        providerobj.cartlist[index]['thumbnail'],
        fit: BoxFit.fill,
      ),
    ),
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

Row titleAndDelete(
    double width, CartProvider providerobj, int index, context, height) {
  return Row(
    children: [
      Container(
        width: width / 3.5,
        child: Text(
          providerobj.cartlist[index]['title'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Spacer(),
      GestureDetector(
          onTap: () {
            dialogeBox(context, height, width, index);
          },
          child: Icon(Icons.delete_outline_outlined))
    ],
  );
}

Future<dynamic> dialogeBox(context, height, double width, index) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          surfaceTintColor: primaryColor,
          title: Center(
              child: Text(
            'Remove From Cart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )),
          content: Container(
            height: height / 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Do you want to remove this item from your cart?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: height * .05,
                      width: width * .25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 197, 197, 197)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Dismiss the dialog
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      height: height * .05,
                      width: width * .25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black),
                      child: TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await Provider.of<CartProvider>(context,
                                  listen: false)
                              .decrementPrice(index);

                          showToast('Removed');
                        },
                        child: Text(
                          'Remove',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ));
    },
  );
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

RatingBar star(CartProvider providerobj, int index) {
  return RatingBar.builder(
    initialRating: providerobj.cartlist[index]['rating'],
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
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

Row priceAndQuantity(
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
        width: width * .27,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  providerobj.itemCountDecreas(index);
                },
                icon: Icon(
                  Icons.remove,
                  size: 17,
                  color: Colors.black,
                )),
            Text(
              providerobj.cartlist[index]['quantity'].toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            IconButton(
                onPressed: () {
                  providerobj.itemCountIncrease(index);
                },
                icon: Icon(
                  Icons.add,
                  size: 17,
                  color: Colors.black,
                ))
          ],
        ),
      )
    ],
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

Container checkoutRow(
    double height, CartProvider providerobj, double width, context) {
  return Container(
    height: height * .12,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: backgroundColor),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total price',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: secondarytextColor),
              ),
              Text(
                '\$ ${providerobj.totalPrice}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              if (providerobj.totalPrice != 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => checkout()));
              } else {
                showToast('No items availble');
              }
            },
            child: Container(
              height: height * .07,
              width: width * .64,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: accentColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Checkout',
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
          )
        ],
      ),
    ),
  );
}
