import 'package:flutter/cupertino.dart';

class CartItem {
  ImageProvider image;
  String name;
  int numberOfItems;
  double costPerItem;
  CartItem(
      {required this.image,
      required this.name,
      required this.numberOfItems,
      required this.costPerItem});

  double totalCost() {
    return numberOfItems * costPerItem;
  }
}
