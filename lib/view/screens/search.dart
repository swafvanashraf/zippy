import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/screens/productDetailsPage.dart';
import 'package:flutter_application_1/viewmodel/providers/dashboardProvider.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            SizedBox(
              height: height * .03,
            ),
            Container(
              height: height / 17,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: searchController,
                focusNode: _focusNode,
                onChanged: (query) =>
                    Provider.of<DashboardProvider>(context, listen: false)
                        .filterList(query, context),
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: secondarytextColor,
                      ),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: secondarytextColor,
                        fontWeight: FontWeight.normal),
                    suffixIcon: Icon(
                      Icons.sort,
                      color: secondarytextColor,
                    )),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: Provider.of<DashboardProvider>(context)
                    .filteredProductList
                    .length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = Provider.of<DashboardProvider>(context)
                      .filteredProductList[index];
                  return ListTile(
                    onTap: () {
                      searchController.clear();
                      _focusNode.unfocus();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetails(product: product)));
                    },
                    title: Text(Provider.of<DashboardProvider>(context)
                        .filteredProductList[index]
                        .title),
                    leading: Image.network(
                      Provider.of<DashboardProvider>(context)
                          .filteredProductList[index]
                          .thumbnail,
                      width: 35,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
