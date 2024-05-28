import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/utils/lists.dart';
import 'package:flutter_application_1/viewmodel/providers/APIprovider.dart';
import 'package:flutter_application_1/viewmodel/providers/dashboardProvider.dart';
import 'package:provider/provider.dart';

Container scrollingCatogories() {
  return Container(
    height: 33, // Adjust the height as needed
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (context, index) {
        double containerWidth = index == 0 ? 55.0 : 90.0;

        return GestureDetector(
          onTap: () {
           
            Provider.of<APIprovider>(context, listen: false)
                .findCategory(catogoriesName[index]);
            Provider.of<DashboardProvider>(context, listen: false)
                .catogoryColor(index);
          },
          child: Container(
            width: containerWidth, // Adjust the width as needed
            height: 20, // Adjust the height as needed
            margin: EdgeInsets.only(right: 9),
            decoration: BoxDecoration(
              border: Border.all(color: accentColor, width: 2),
              borderRadius: BorderRadius.circular(25),
              color: Provider.of<DashboardProvider>(
                        context,
                      ).myindex ==
                      index
                  ? accentColor
                  : backgroundColor,
            ),
            child: Center(
                child: Text(
              catogoryNames[index],
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Provider.of<DashboardProvider>(
                            context,
                          ).myindex ==
                          index
                      ? backgroundColor
                      : accentColor),
            )),
          ),
        );
      },
    ),
  );
}

SizedBox categoryProducts(BuildContext context, double height, double width) {
  return SizedBox(
    height: height * 1.05,
    child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            childAspectRatio: .64),
        itemCount: Provider.of<APIprovider>(context).categoryProducts.length,
        itemBuilder: (context, index) {
          Product product =
              Provider.of<APIprovider>(context).categoryProducts[index];

          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: Colors.black12,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: height / 5.5,
                    width: width / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.fitHeight,
                      ),
                    )),
                SizedBox(
                  height: height / 70,
                ),
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  '\$${product.price}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height / 70),
                Container(
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  height: height / 25,
                  width: width / 2,
                  child: Center(
                    child: Text(
                      'Add to cart',
                      style: TextStyle(fontSize: 11, color: maintextColor),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
  );
}
