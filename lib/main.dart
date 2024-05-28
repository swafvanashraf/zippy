import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/commun_widgets.dart';
import 'package:flutter_application_1/viewmodel/providers/Connectivity_provider.dart';
import 'package:flutter_application_1/viewmodel/providers/authProvider.dart';
import 'package:flutter_application_1/viewmodel/firebase_options.dart';
import 'package:flutter_application_1/viewmodel/providers/APIprovider.dart';
import 'package:flutter_application_1/view/screens/firstSplash.dart';
import 'package:flutter_application_1/viewmodel/providers/cart_provider.dart';
import 'package:flutter_application_1/viewmodel/providers/checkOutProvider.dart';
import 'package:flutter_application_1/viewmodel/providers/dashboardProvider.dart';
import 'package:flutter_application_1/viewmodel/providers/orders_provider.dart';
import 'package:flutter_application_1/viewmodel/providers/productDetailsProvider.dart';
import 'package:flutter_application_1/viewmodel/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('asset/light.jpg'), context);
    precacheImage(
        AssetImage(
          'asset/ad_one.jpg',
        ),
        context);
    precacheImage(AssetImage('asset/ad_two.jpg'), context);
    precacheImage(AssetImage('asset/ad_three.jpg'), context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => APIprovider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => wishlistProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => productDetailsProvider()),
        ChangeNotifierProvider(create: (context) => CheckoutProvider()),
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
      ],
      child: MaterialApp(
        home: FirstSplashScreen(),
      ),
    );
  }
}
