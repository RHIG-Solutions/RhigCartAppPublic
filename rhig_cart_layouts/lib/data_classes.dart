import 'package:flutter/material.dart';

class Shopper {
  String id;

  Shopper({required this.id});
}

class _CartItem {
  ImageProvider image;
  String item;
  double costPerItem;
  int numberOfItems;
  _CartItem(
      {required this.image,
      required this.item,
      required this.numberOfItems,
      required this.costPerItem});
}
