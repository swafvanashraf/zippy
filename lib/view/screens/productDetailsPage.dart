

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/utils/const.dart';

import 'package:flutter_application_1/view/widget/productDetailWidgets.dart';
import 'package:flutter_application_1/viewmodel/providers/productDetailsProvider.dart';
import 'package:flutter_application_1/viewmodel/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  bool rebuildOff = false;
  imageIndex() {
    rebuildOff = true;
    Provider.of<productDetailsProvider>(context).selectImageIndex = 0;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Product product = widget.product;

    if (rebuildOff == false) {
      imageIndex();
    }
    bool isInWishlist = Provider.of<wishlistProvider>(context,)
        .wishlistId
        .contains(product.id);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productView(height, width, product, context),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleRow(product, context, isInWishlist),
                  stocksRow(height, width, product),
                  SizedBox(
                    height: height * .015,
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      'Discription',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    height: height / 19,
                    child: Text(
                      product.description,
                      style: TextStyle(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Color',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  colors(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Divider(),
                  ),
                  addCartRow(product, height, width, context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
