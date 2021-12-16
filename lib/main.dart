import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart' as Con;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';

import './utils.dart';

import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/orders_screen.dart';
import './provider/products.dart';
import './provider/cart.dart';
import './provider/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    subscription = Con.Connectivity()
        .onConnectivityChanged
        .listen(showConnectivitySnackBar);
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Products()),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProvider(create: (ctx) => Orders()),
        ],
        child: MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: ProductOverviewScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
            }),
      ),
    );
  }
}

void showConnectivitySnackBar(Con.ConnectivityResult result) {
  final hasInternet = result != Con.ConnectivityResult.none;
  final message = hasInternet
      ? 'You have again ${result.toString()}'
      : 'You have no internet';
  final color = hasInternet ? Colors.green : Colors.red;

  Utils.showTopSnackBar(message, color);
}
