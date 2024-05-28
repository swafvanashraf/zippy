import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/utils/lists.dart';
import 'package:flutter_application_1/viewmodel/providers/APIprovider.dart';
import 'package:flutter_application_1/viewmodel/providers/cart_provider.dart';
import 'package:flutter_application_1/viewmodel/providers/productDetailsProvider.dart';
import 'package:flutter_application_1/viewmodel/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

Container productView(
    double height, double width, Product product, BuildContext context) {
  return Container(
    height: height / 2.5,
    color: primaryColor,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          SizedBox(
            height: height * .25,
            width: width / 6,
            child: ListView.builder(
              itemCount: product.images.length <= 3 ? product.images.length : 3,
              padding: EdgeInsets.symmetric(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Provider.of<productDetailsProvider>(context, listen: false)
                        .changeImage(index);
                  },
                  child: Provider.of<APIprovider>(context).dataFetched == false
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: height / 16,
                            width: height / 16,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: Provider.of<productDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .selectImageIndex ==
                                          index
                                      ? 2
                                      : 1,
                                  color: Provider.of<productDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .selectImageIndex ==
                                          index
                                      ? Colors.green
                                      : Colors.black)),
                          margin: EdgeInsets.all(8),
                          height: height / 16,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.network(
                                  product.images[index],
                                  fit: BoxFit.cover,
                                ),
                                Positioned.fill(
                                  child: Container(
                                      color:
                                          Provider.of<productDetailsProvider>(
                                                          context)
                                                      .selectImageIndex ==
                                                  index
                                              ? Color.fromARGB(64, 12, 12, 12)
                                              : Colors.transparent),
                                ),
                              ],
                            ),
                          ),
                        ),
                );
              },
            ),
          ),
          SizedBox(
            width: width / 16,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1)),
            height: height / 3,
            width: width / 1.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.images[Provider.of<productDetailsProvider>(context)
                    .selectImageIndex],
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

//////////////////////////////////////////////////////////////////////////////

Row titleRow(Product product, context, isInWishlist) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
        ),
      ),
      IconButton(
          onPressed: () {
            Provider.of<wishlistProvider>(context, listen: false)
                .addOrRemove(product, isInWishlist);
            Provider.of<wishlistProvider>(context, listen: false)
                .wishlistToFirestore(product);
          },
          icon: Icon(
            Icons.favorite_outlined,
            color: isInWishlist == true ? Colors.red : Colors.grey,
          ))
    ],
  );
}

//////////////////////////////////////////////////////////////////////////////////////////

Row stocksRow(double height, double width, Product product) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(5)),
        height: height / 26,
        width: width / 5,
        child: Center(
            child: Text(
          '${product.stock} Stocks' as String,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        )),
      ),
      SizedBox(
        width: width / 40,
      ),
      Text(
        '⭐ ${product.rating}',
        style: TextStyle(fontSize: 13),
      ),
      SizedBox(
        width: width / 25,
      ),
      // Container(
      //   height: height / 20,
      //   width: width / 2,
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(10), color: primaryColor),
      //   child: Center(
      //     child: Text('Buy Now'),
      //   ),
      // ),
    ],
  );
}

/////////////////////////////////////////////////////////////////////////////////////////////////

GridView colors() {
  return GridView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 7,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 10,
        childAspectRatio: .95,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Provider.of<productDetailsProvider>(context, listen: false)
                .colorSelect(index);
          },
          child: CircleAvatar(
              radius: 20,
              backgroundColor: darkColors[index],
              child: Provider.of<productDetailsProvider>(
                        context,
                      ).selectedColorIndex ==
                      index
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  : null),
        );
      });
}

////////////////////////////////////////////////////////////////////////

Row addCartRow(
  Product product,
  double height,
  double width,
  context,
) {
  return Row(
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
            '\$ ${product.price.toString()}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ],
      ),
      GestureDetector(
        onTap: () {
          Provider.of<CartProvider>(context, listen: false)
              .cartToFirestore(product);
        },
        child: Container(
          height: height * .07,
          width: width * .65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: accentColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_rounded,
                color: Colors.white,
              ),
              SizedBox(
                width: width * .02,
              ),
              Text(
                'Add to Cart',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              )
            ],
          ),
        ),
      )
    ],
  );
}
