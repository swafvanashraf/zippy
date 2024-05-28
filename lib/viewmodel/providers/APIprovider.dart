import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIprovider with ChangeNotifier {
  late FetchData fetchData =
      FetchData(products: [], total: 0, skip: 0, limit: 0);

  bool dataFetched = false;

  Future<void> fetchDataFromApi() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the data
        final Map<String, dynamic> data = json.decode(response.body);
        // print("Response Data: $data");

        fetchData = FetchData.fromJson(data);
// print("fetchData: $fetchData");
        notifyListeners();
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle exceptions
      print("Error: $e");
    }
    dataFetched = true;
  }
  ////////////////////////////////////////////////////

  // bool isloading = false;
  // loading() {
  //   isloading = !isloading;
  //   notifyListeners();
  // }

  ////////////////////////////////////////////////////////////////////////////////////////////

  // checkDocumentsWithId() async {
  //   DocumentSnapshot userdata = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .get();
  //   if (userdata.exists) {
  //     Map<String, dynamic>? userDataMap =
  //         userdata.data() as Map<String, dynamic>?;

  //     List<dynamic>? wishlist =
  //         List.from(userDataMap?['wishlist'] as List<dynamic>);

  //     List wishlistIds = wishlist.map((item) => item['id'].toInt()).toList();

  //     for (int index in wishlistIds) {
  //       if (index >= 0 && index <= fetchData.products.length) {
  //         fetchData.products[index - 1].isInWishlist = true;
  //       }
  //     }
  //   }
  //   notifyListeners();
  // }

///////////////////////////////////////////////////////////////////////////////////////

  List<Product> categoryProducts = [];
  findCategory(category) {
    categoryProducts = fetchData.products
        .where((product) => product.category == category)
        .toList();
    notifyListeners();
  }
}
