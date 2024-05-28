import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/screens/productDetailsPage.dart';
import 'package:flutter_application_1/viewmodel/providers/APIprovider.dart';
import 'package:provider/provider.dart';

class offers extends StatefulWidget {
  const offers({super.key});

  @override
  State<offers> createState() => _offersState();
}

class _offersState extends State<offers> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: height * .07,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
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
                  'Special offers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                ),
              ],
            ),
            SizedBox(
              height: height * .035,
            ),
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
                height: height * .22,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: primaryColor),
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
            SizedBox(
              height: height * .035,
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
                height: height * .22,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: primaryColor),
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
            SizedBox(
              height: height * .035,
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
                height: height * .22,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: primaryColor),
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
        ),
      ),
    );
  }
}
