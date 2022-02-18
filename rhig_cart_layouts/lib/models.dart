import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/reusables.dart';

enum DeliveryMethod { door2door, pickup, collect }

class ShopperModel {
  String id;
  String vendorId = '';
  DeliveryMethod deliveryMethod = DeliveryMethod.door2door;
  double totalCost = 0;
  List<CartItem> cart = [];

  ShopperModel({required this.id}) {
    _populate();
  }

  //TODO: Sort out proper data handling via session or net. Just a dummy populate atm.
  void _populate() {
    vendorId = 'Vendor ID';
    for (var counter = 0; counter < 4; counter++) {
      cart.add(
        CartItem(
            image: const AssetImage('assets/images/test_image_1.png'),
            item: 'Item ' + (counter + 1).toString(),
            numberOfItems: 1,
            costPerItem: 20),
      );
      totalCost = totalCost + cart[counter].costPerItem;
    }
  }

  void deleteItem(_itemNumber) {
    totalCost = totalCost -
        (cart[_itemNumber].costPerItem * cart[_itemNumber].numberOfItems);
    cart.removeAt(_itemNumber);
  }

  void increaseNumber(_itemNumber) {
    totalCost = totalCost + cart[_itemNumber].costPerItem;
    cart[_itemNumber].numberOfItems++;
  }

  void decreaseNumber(_itemNumber) {
    if (cart[_itemNumber].numberOfItems == 1) {
      deleteItem(_itemNumber);
    } else {
      totalCost = totalCost - cart[_itemNumber].costPerItem;
      cart[_itemNumber].numberOfItems--;
    }
  }

  void setNumber(_itemNumber, newNumber) {
    totalCost = totalCost -
        (cart[_itemNumber].numberOfItems * cart[_itemNumber].costPerItem);
    cart[_itemNumber].numberOfItems = newNumber;
    totalCost = totalCost +
        (cart[_itemNumber].numberOfItems * cart[_itemNumber].costPerItem);
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

class CartItem {
  ImageProvider image;
  String item;
  double costPerItem;
  int numberOfItems;
  CartItem(
      {required this.image,
      required this.item,
      required this.numberOfItems,
      required this.costPerItem});
}

class VendorModel {
  ImageProvider image = const AssetImage('assets/images/image_missing.png');
  String name;
  double starRating = 0;
  String description = '';
  bool isFavourite = false;
  List<GridListItem> categories = [];
  List<String> tags = [];
  final int _numberOfCategories = 9;

  VendorModel({required this.name}) {
    _populate();
  }

  //TODO: Populate Vendor info off the web.
  _populate() {
    image = const AssetImage('assets/images/test_image_2.png');
    starRating = 2.5;
    isFavourite = true;
    description = 'Vendor description here';
    tags.add('Clothing');
    tags.add('Casual');
    tags.add('Adult');
    tags.add('Male');
    for (var counter = 0; counter < _numberOfCategories; counter++) {
      categories.add(
        GridListItem(
          description: 'Category ' + (counter + 1).toString(),
          image: const AssetImage('assets/images/test_image_1.png'),
        ),
      );
    }
  }

  //TODO: Add functionality to change favourite status on the database
  toggleFavourite() {
    //Toggle does not work atm as the data is not updated in the database on
    //button press
    isFavourite = !isFavourite;
  }

  Widget drawCategories(BuildContext context) {
    //TODO: Decide on fixed vs flex boxes, switch to the following if fixed is chosen(remember to do reusables as well)
    // return Build2DGrid(
    //   myList: categories,
    //   target: '/productitem',
    // );
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
        child: GridView.extent(
          maxCrossAxisExtent: 150.0,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
          children: [
            for (var counter = 0; counter < categories.length; counter++)
              BuildImageAndTextBox(
                  description: categories[counter].description,
                  image: categories[counter].image,
                  target: '/productitem'),
          ],
        ),
      ),
    );
  }
}

//Class to hold list of item information to populate Grid views
class GridListItem {
  ImageProvider image;
  String description;

  GridListItem({required this.image, required this.description});
}
