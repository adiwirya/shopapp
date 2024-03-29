import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CardItem extends StatelessWidget {
  final String id;
  final double price;
  final String productId;
  final int quantity;
  final String title;

  CardItem({
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                child:
                    FittedBox(child: Text("\$" + price.toStringAsFixed(2))),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total: \$" + (price * quantity).toStringAsFixed(2)),
            trailing: Text("Qty : $quantity"),
          ),
        ),
      ),
    );
  }
}
