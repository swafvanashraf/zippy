import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/products_API.dart';
import 'package:flutter_application_1/view/screens/editProfile.dart';
import 'package:flutter_application_1/view/screens/orders.dart';

List<String> images = [
  'asset/three_dot.png',
  'asset/mobile.png',
  'asset/laptop.png',
  'asset/fragrence.png',
  'asset/skincare.png',
  'asset/gr.png',
  'asset/home.png',
  'asset/jewellery.png',
];

List<String> catogoryNames = [
  'All',
  'Phones',
  'Laptops',
  'Fragrance',
  'Skincare',
  'Groceries',
  'Home',
  'Jewellery',
];

List<String> catogoriesName = [
  'All',
  'smartphones',
  'laptops',
  'fragrances',
  'skincare',
  'groceries',
  'home-decoration',
  'Jewellery',
];

List<Color> darkColors = [
  Color(0xFF8B0000), // Dark Red
  Color(0xFF006400), // Dark Green
  Color(0xFF00008B), // Dark Blue
  Color(0xFF4B0082), // Dark Purple
  Color(0xFF008080), // Dark Teal
  Color(0xFF8B4513), // Dark Brown
  Color(0xFF404040), // Dark Gray
];

List<String> shippingTypeName = [
  'Economy',
  'Regular',
  'Cargo',
  'Express',
];
List<String> shippingTypeDays = [
  'Arrival within 7 days',
  'Arrival within 5 days',
  'Arrival within 3 days',
  'Arrival within 1 day',
];
List<int> shippingPrices = [10, 15, 20, 30];

List<Image> shippingIcons = [
  Image.asset(
    'asset/economy.png',
    width: 20,
    height: 20,
    color: Colors.white,
  ),
  Image.asset(
    'asset/regular.png',
    width: 20,
    height: 20,
    color: Colors.white,
  ),
  Image.asset(
    'asset/cargo.png',
    width: 20,
    height: 20,
    color: Colors.white,
  ),
  Image.asset(
    'asset/express.png',
    width: 30,
    height: 30,
    color: Colors.white,
  ),
];

List<String> profileNames = [
  'Edit profile',
  'Notification',
  'Privacy policy',
  'Help centre',
  'Invite friends',
  'Logout'
];

List<Icon> icons = [
  Icon(Icons.person_3_outlined),
  Icon(Icons.notifications_none_outlined),
  Icon(Icons.lock_outline_rounded),
  Icon(Icons.help_outline_outlined),
  Icon(Icons.person_add_alt_1_outlined),
  Icon(
    Icons.logout_outlined,
    color: Colors.red,
  ),
];

List<Widget> pages = [
  editProfile(),
  editProfile(),
  editProfile(),
  editProfile(),
  editProfile(),
];
