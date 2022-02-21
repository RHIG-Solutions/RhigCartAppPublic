import 'package:flutter/cupertino.dart';
import 'cart_item_model.dart';
import 'package:rhig_cart_layouts/reusables.dart';

class User {
  String name = '';
  DeliveryMethod deliveryMethod = DeliveryMethod.door2door;
  List<CartItem> cart = [];

  User() {
    populate();
  }

  //TODO: replace dummy populate
  void populate() {
    name = 'User';
    for (var i = 0; i < 4; i++) {
      cart.add(CartItem(
          image: const AssetImage('assets/images/test_image_1.png'),
          name: 'Item ' + (i + 1).toString(),
          numberOfItems: 1,
          costPerItem: 20.0));
    }
  }

  double getCartTotal() {
    double total = 0;
    for (var i = 0; i < cart.length; i++) {
      total = total + cart[i].totalCost();
    }
    return total;
  }

  void deleteItem(_itemNumber) {
    cart.removeAt(_itemNumber);
  }

  void increaseNumber(_itemNumber) {
    cart[_itemNumber].numberOfItems++;
  }

  void decreaseNumber(_itemNumber) {
    if (cart[_itemNumber].numberOfItems == 1) {
      deleteItem(_itemNumber);
    } else {
      cart[_itemNumber].numberOfItems--;
    }
  }

  void setNumber(_itemNumber, newNumber) {
    cart[_itemNumber].numberOfItems = newNumber;
  }

  int countItems() {
    var itemCount = 0;
    for (var i = 0; i < cart.length; i++) {
      itemCount = itemCount + cart[i].numberOfItems;
    }
    return itemCount;
  }

  String getDeliveryMethod() {
    if (deliveryMethod == DeliveryMethod.door2door) {
      return 'Door to Door';
    } else if (deliveryMethod == DeliveryMethod.collect) {
      return 'Collect';
    } else {
      return 'Pickup';
    }
  }
}
