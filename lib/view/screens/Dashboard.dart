import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/widget/dashboardWidgets.dart';
import 'package:flutter_application_1/viewmodel/providers/APIprovider.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/viewmodel/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<FetchData>> futureData;
  @override
  void initState() {
    Provider.of<APIprovider>(context, listen: false).fetchDataFromApi();
    Provider.of<wishlistProvider>(context, listen: false).getWishlistId();
    super.initState();
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: height * .03,
              ),
              nameRow(width, context),
              SizedBox(
                height: height * .03,
              ),
              textfield(height, context),
              SizedBox(
                height: height * .02,
              ),
              speacialOfferRow(context),
              SizedBox(
                height: height * .02,
              ),
              Provider.of<APIprovider>(context).dataFetched == false
                  ? shimmer(height)
                  : carouselSlider(context, height, width),
              categories(height),
              // SizedBox(
              //   height: height * .03,
              // ),
              // popularRow(),
              // SizedBox(
              //   height: height * .03,
              //),
              // scrollingCatogories(),
              Provider.of<APIprovider>(context).dataFetched == false
                  ? Column(
                      children: [
                        SizedBox(
                          height: height * .05,
                        ),
                        CircularProgressIndicator(),
                      ],
                    )
                  : products(height, context, width)
            ],
          ),
        ),
      ),
    );
  }
}
