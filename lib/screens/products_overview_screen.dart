import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/product_grid.dart';
import '../widgets/app_drawer.dart';
import '../provider/cart.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorites) {
                setState(() {
                  _showOnlyFavorites = true;
                });
              } else {
                setState(() {
                  _showOnlyFavorites = false;
                });
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.Favorites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, __) => Badge(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: Icon(Icons.shopping_cart)),
              value: cart.itemCount.toString(),
              color: Colors.red,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      body: ProductGrid(_showOnlyFavorites),
      drawer: AppDrawer(),
    );
  }
}
