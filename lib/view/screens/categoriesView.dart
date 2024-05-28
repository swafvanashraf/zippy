import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/widget/categoryWidgets.dart';
import 'package:flutter_application_1/view/widget/dashboardWidgets.dart';
import 'package:flutter_application_1/viewmodel/providers/dashboardProvider.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: width / 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: scrollingCatogories()),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Provider.of<DashboardProvider>(context).myindex == 0
                  ? products(height, context, width)
                  : categoryProducts(context, height, width),
            ),
          ],
        ),
      ),
    );
  }
}
