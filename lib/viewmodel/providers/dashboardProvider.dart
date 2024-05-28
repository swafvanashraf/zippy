import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/viewmodel/providers/APIprovider.dart';
import 'package:provider/provider.dart';

class DashboardProvider extends ChangeNotifier {
  List<dynamic> filteredProductList = [];

  filterList(String query, context) {
    List<Product> originalProductList =
        Provider.of<APIprovider>(context, listen: false).fetchData.products;

    if (query.isEmpty) {
      filteredProductList = List.empty();
    } else {
      filteredProductList = originalProductList.where((item) {
        return item.title.toLowerCase().startsWith(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////
  int myindex = 0;

  catogoryColor(index) {
    myindex = index;
    notifyListeners();
  }

  int currentIndex = 0;

  carouselIndex(index) {
    currentIndex = index;
    notifyListeners();
  }
}
