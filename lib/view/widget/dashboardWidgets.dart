import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/utils/lists.dart';
import 'package:flutter_application_1/view/screens/categoriesView.dart';
import 'package:flutter_application_1/view/screens/editProfile.dart';
import 'package:flutter_application_1/view/screens/offers.dart';
import 'package:flutter_application_1/view/screens/productDetailsPage.dart';
import 'package:flutter_application_1/view/screens/search.dart';
import 'package:flutter_application_1/view/screens/wishlist.dart';
import 'package:flutter_application_1/viewmodel/providers/APIprovider.dart';
import 'package:flutter_application_1/viewmodel/providers/cart_provider.dart';
import 'package:flutter_application_1/viewmodel/providers/dashboardProvider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

User? user = FirebaseAuth.instance.currentUser;

Row nameRow(double width, context) {
  return Row(
    children: [
      CircleAvatar(
          backgroundColor: primaryColor,
          radius: 25,
          child: user?.photoURL != null
              ? ClipOval(
                  child: Image.network(
                    user!.photoURL!,
                    fit: BoxFit.fill,
                  ),
                )
              : Container()),
      SizedBox(
        width: width * .03,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi👋'),
            Text(
              user?.displayName ?? 'Guest',
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: maintextColor),
            )
          ],
        ),
      ),
      Spacer(),
      IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => editProfile()));
          },
          icon: Icon(Icons.notifications_active_outlined)),
      IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => wishlist_page()));
          },
          icon: Icon(Icons.favorite_border_sharp))
    ],
  );
}

///////////////////////////////////////////////////////////////////////////////////////////////

GestureDetector textfield(double height, context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Search()));
    },
    child: Container(
        height: height / 17,
        width: double.infinity,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                color: secondarytextColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Search',
                style: TextStyle(color: Colors.grey, fontSize: 15.5),
              ),
              Spacer(),
              Icon(
                Icons.sort,
                color: secondarytextColor,
              )
            ],
          ),
        )

        // TextField(
        //   decoration: InputDecoration(
        //       border: InputBorder.none,
        //       prefixIcon: Icon(
        //         Icons.search_rounded,
        //         color: secondarytextColor,
        //       ),
        //       hintText: 'Search',
        //       hintStyle: TextStyle(
        //           color: secondarytextColor, fontWeight: FontWeight.normal),
        //       suffixIcon: Icon(Icons.sort)),
        // ),
        ),
  );
}

//////////////////////////////////////////////////////////////////////////////////////////////

Shimmer shimmer(height) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
          height: 180.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: primaryColor)));
}

////////////////////////////////////////////////////////////////////////////////////////////

Stack carouselSlider(context, height, width) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      CarouselSlider(
        items: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(
                          product: Provider.of<APIprovider>(context)
                              .fetchData
                              .products[1])));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '25%',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                        SizedBox(
                          height: height * .005,
                        ),
                        Text(
                          "Today's Special!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: height * .015,
                        ),
                        Expanded(
                          child: Text(
                            'Get discount for every \norder, only valid for today ',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(150, 0, 0, 0)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    height: height / 6,
                    child: Image.asset(
                      'asset/iphone.png',
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(
                          product: Provider.of<APIprovider>(context)
                              .fetchData
                              .products[12])));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '30%',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                        SizedBox(
                          height: height * .005,
                        ),
                        Text(
                          "Seize the moment!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: height * .015,
                        ),
                        Expanded(
                          child: Text(
                            'Free Fogg with every order\nLimited-time offer.',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(150, 0, 0, 0)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    height: height / 6,
                    // width: width / 10,
                    child: Image.asset(
                      'asset/fogg.png',
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(
                          product: Provider.of<APIprovider>(context)
                              .fetchData
                              .products[18])));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '10%',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                        SizedBox(
                          height: height * .005,
                        ),
                        Text(
                          "Offer ends soon!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: height * .015,
                        ),
                        Expanded(
                          child: Text(
                            'Free with every order.\nElevate your skincare routine',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(150, 0, 0, 0)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    height: height / 5,
                    child: Image.asset(
                      'asset/skin.png',
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          height: 180.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            Provider.of<DashboardProvider>(context, listen: false)
                .carouselIndex(index);
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
      Positioned(
        bottom: 5,
        child: DotsIndicator(
          dotsCount: 3,
          position: Provider.of<DashboardProvider>(context).currentIndex,
          decorator: DotsDecorator(
            color: Colors.grey, // Inactive dot color
            activeColor: Colors.black,
            size: Size(7.0, 7.0), // Dot size
            activeSize: Size(9.0, 9.0), // Active dot size
            spacing: EdgeInsets.all(4.0),
          ),
        ),
      )
    ],
  );
}

/////////////////////////////////////////////////////////////////////////////////////

Row speacialOfferRow(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Special Offers',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: maintextColor),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => offers()));
        },
        child: Text(
          'See All',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: maintextColor),
        ),
      ),
    ],
  );
}

///////////////////////////////////////////////////////////////////////////////////////////////

GridView categories(double height) {
  return GridView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        childAspectRatio: .95,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Provider.of<APIprovider>(context, listen: false)
                .findCategory(catogoriesName[index]);
            Provider.of<DashboardProvider>(context, listen: false)
                .catogoryColor(index);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoriesPage()));
          },
          child: Container(
            color: backgroundColor,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 29,
                  backgroundColor: primaryColor,
                  child: Image.asset(
                    images[index],
                    scale: height / 50,
                    color: accentColor,
                  ),
                ),
                Spacer(),
                Text(
                  catogoryNames[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: maintextColor,
                      fontSize: 13),
                )
              ],
            ),
          ),
        );
      });
}

//////////////////////////////////////////////////////////////////////////////////////////////

Row popularRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Most Popular',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: maintextColor,
          fontSize: 18,
        ),
      ),
      Text(
        'See All',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: maintextColor, fontSize: 14),
      )
    ],
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

bool isloading = false;

////////////////////////////////////////////////////////////////////////////////////////////////////////

SizedBox products(double height, BuildContext context, double width) {
  return SizedBox(
    height: height * 5.33,
    child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            childAspectRatio: .64),
        itemCount: Provider.of<APIprovider>(context).fetchData.products.length,
        itemBuilder: (context, index) {
          Product product =
              Provider.of<APIprovider>(context).fetchData.products[index];

          return GestureDetector(
            onTap: () {
              // Provider.of<wishlistProvider>(context,listen: false).selectedindex=product.id-1;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(product: product)));
            },
            child: Container(
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
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    '\$${product.price}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height / 70),
                  GestureDetector(
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .cartToFirestore(product);
                    },
                    child: Container(
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
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}


  ///////////////////////////////////////////////////////////////////////////////////////////////////////////
  






  




  