import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/const.dart';
import 'package:flutter_application_1/view/screens/CartPage.dart';
import 'package:flutter_application_1/view/screens/Dashboard.dart';
import 'package:flutter_application_1/view/screens/orders.dart';
import 'package:flutter_application_1/view/screens/profile.dart';
import 'package:flutter_application_1/view/screens/wishlist.dart';

class bottumNavigationbar extends StatefulWidget {
  const bottumNavigationbar({super.key});

  State<bottumNavigationbar> createState() => _bottumNavigationbarState();
}

class _bottumNavigationbarState extends State<bottumNavigationbar> {
  int _selectedIndex = 0;
 
  final List<Widget> _widgetOptions = [
    Dashboard(),
    Cart(),
    wishlist_page(),
    Orders(),
    profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          backgroundColor: backgroundColor,
          unselectedItemColor: secondaryColor,
          selectedFontSize: 12,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: 'Home',
              backgroundColor: backgroundColor,
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: 'Cart',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Wishlist',
                backgroundColor: backgroundColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag,
                ),
                label: 'Orders',
                backgroundColor: backgroundColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_sharp,
                ),
                label: 'Profile',
                backgroundColor: backgroundColor),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: accentColor,
          onTap: _onItemTapped,
        ));
  }
}
