import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';
import 'package:intl/intl.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  CartController myCart = CartController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Material(
          color: Colors.white,
          elevation: kElevation,
          //TODO: Implementation is VERY messy, stopped until more is known about the database
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
            child: Column(
              children: [
                const SizedBox(height: 15.0),
                for (var counter = 0;
                    counter < myCart.cartItems.length;
                    counter++)
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(myCart.cartItems[counter].image,
                              height: 60.0),
                          const SizedBox(width: 5.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildNameRow(counter),
                              const SizedBox(height: 5),
                              buildCostRow(
                                  costPerItem:
                                      myCart.cartItems[counter].costPerItem,
                                  numberOfItems:
                                      myCart.cartItems[counter].numberOfItems),
                            ],
                          ),
                        ],
                      ),
                      BuildDivider().draw(isIndented: false),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: kBottomButtonPadding,
        child: BuildButton(
          title: 'Check Out',
          onPressed: () {
            Navigator.pushNamed(context, '/deliverymethod');
          },
        ),
      ),
    );
  }

  Text buildNameRow(int counter) {
    return Text(
      myCart.cartItems[counter].numberOfItems.toString() +
          ' x ' +
          myCart.cartItems[counter].name,
      style: kCartNameTextStyle,
    );
  }
}

Text buildCostRow({required int numberOfItems, required double costPerItem}) {
  double _totalCost = numberOfItems * costPerItem;
  var f = NumberFormat.currency(symbol: '\$');

  return Text(
    numberOfItems.toString() +
        ' x ' +
        f.format(costPerItem).toString() +
        ' = ' +
        f.format(_totalCost).toString(),
    style: kCartBodyTextStyle,
  );
}

//Dummy Cart class with 3 items, cannot add more just remove. Has VERY basic
//functionality for interface testing
class CartController {
  List<_CartSpecifics> cartItems = [];
  double totalCost = 0.0;
  CartController() {
    for (var counter = 0; counter < 3; counter++) {
      cartItems.add(_CartSpecifics(name: 'Item ' + (counter + 1).toString()));
      totalCost = totalCost + cartItems[counter].costPerItem;
    }
  }
  void deleteItem(int itemNumber) {
    cartItems.removeAt(itemNumber);
  }

  void increaseNumber(itemNumber) {
    cartItems[itemNumber].numberOfItems++;
    totalCost = totalCost + cartItems[itemNumber].costPerItem;
  }

  void decreaseNumber(itemNumber) {
    if (cartItems[itemNumber].numberOfItems > 1) {
      cartItems[itemNumber].numberOfItems--;
      totalCost = totalCost - cartItems[itemNumber].costPerItem;
    } else {
      deleteItem(itemNumber);
    }
  }
}

class _CartSpecifics {
  String image = 'assets/images/test_image_1.png';
  String name;
  int numberOfItems = 1;
  double costPerItem = 20.00;
  _CartSpecifics({required this.name});
}
