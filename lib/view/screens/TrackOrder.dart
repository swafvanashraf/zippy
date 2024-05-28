import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/widget/modified_stepper.dart';
import 'package:flutter_application_1/viewmodel/providers/orders_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({
    super.key,
    required this.product,
    required this.Quantity,
  });
  final Product product;
  final Quantity;
  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final providerobj = Provider.of<OrdersProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 228, 228),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                    'Track Order',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ],
              ),
              SizedBox(
                height: height * .035,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: height / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(19),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height / 3,
                          width: width / 4,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: primaryColor, width: 1)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              product.thumbnail,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * .04,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width / 3.5,
                                child: Text(
                                  product.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: product.rating,
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
                                  ),
                                  Text('  |  Qty =${widget.Quantity}')
                                ],
                              ),
                              Text(
                                '\$${product.price}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
              Image.asset(
                'asset/track.png',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  'Packet in delivery',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Order status details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ),
              ),
              ModifiedStepper(
                physics: ClampingScrollPhysics(),
                controlsBuilder:
                    (BuildContext context, ControlDetails controlsDetails) {
                  return Container(
                    color: Colors.amber,
                  ); // Empty Container
                },
                steps: const [
                  ModifiedStep(
                    isActive: true,
                    title: Text(
                      'Order placed',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your order has been placed.',
                            style: TextStyle(fontSize: 17),
                          ),
                          Text("Sun,16th Oct '22 - 10:27pm")
                        ],
                      ),
                    ),
                  ),
                  ModifiedStep(
                    isActive: true,
                    title: Text(
                      'Shipped',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your item has been shipped.',
                            style: TextStyle(fontSize: 17),
                          ),
                          Text("mon,17th Oct '22 - 07:27pm")
                        ],
                      ),
                    ),
                  ),
                  ModifiedStep(
                    title: Text(
                      'Out for delivery',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your item will be out for delivery',
                            style: TextStyle(fontSize: 17),
                          ),
                          Text("wed,19th Oct '22 - 10:56pm")
                        ],
                      ),
                    ),
                  ),
                  ModifiedStep(
                    title: Text(
                      'Delivered',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your item will be delivered ',
                            style: TextStyle(fontSize: 17),
                          ),
                          Text("wed,19th Oct '22 - 10:56pm")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              
            ],
          ),
        ),
      ),
    );
  }
}
