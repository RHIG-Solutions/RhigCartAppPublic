import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';
import 'package:intl/intl.dart';
import 'package:rhig_cart_layouts/models/user_model.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  //TODO: Integrate session
  //TODO: Address overflow issues with large number of items.
  User myShopper = User();
  var f = NumberFormat.currency(symbol: '\$');
  final List<TextEditingController> _itemNumberTextController = [];

  @override
  Widget build(BuildContext context) {
    //Don't know if this will be needed later. if a cart state can be saved
    //between sessions then leave this in, if not, it can be removed as the
    //TextEditingController list will be empty
    if (myShopper.cart.isNotEmpty) {
      for (var i = 0; i < myShopper.cart.length; i++) {
        _itemNumberTextController.add(TextEditingController());
        _itemNumberTextController[i].text =
            myShopper.cart[i].numberOfItems.toString();
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          child: Material(
            color: Colors.white,
            elevation: kElevation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  for (var counter = 0;
                      counter < myShopper.cart.length;
                      counter++)
                    Column(
                      children: [
                        Row(
                          children: [
                            Image(
                                image: myShopper.cart[counter].image,
                                height: 60.0),
                            const SizedBox(width: 5.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildNameRow(counter),
                                const SizedBox(height: 15),
                                _buildCostRow(counter),
                              ],
                            ),
                            Expanded(child: Container()),
                            _buildNumberControls(counter),
                          ],
                        ),
                        buildDividerLight(),
                      ],
                    ),
                  const SizedBox(height: 10.0),
                  _buildTotalRow(),
                  const SizedBox(height: 20.0),
                ],
              ),
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

  Widget _buildNameRow(int counter) {
    return Text(
      myShopper.cart[counter].numberOfItems.toString() +
          ' x ' +
          myShopper.cart[counter].name,
      style: const TextStyle(
        color: kRHIGGreen,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCostRow(int counter) {
    return Text(
      myShopper.cart[counter].numberOfItems.toString() +
          ' x ' +
          f.format(myShopper.cart[counter].costPerItem).toString() +
          ' = ' +
          f
              .format(myShopper.cart[counter].numberOfItems *
                  myShopper.cart[counter].costPerItem)
              .toString(),
      style: const TextStyle(
        color: kRHIGGrey,
        fontSize: 10,
      ),
    );
  }

  //TODO:Decide on edit icon, i see no use
  //TODO:Do you want an "are you sure" warning before deleting item
  Widget _buildNumberControls(counter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildIconButton(
            icon: Icons.delete_forever_outlined,
            onPressed: () {
              setState(() {
                myShopper.deleteItem(counter);
              });
            }),
        Row(
          children: [
            _buildIconButton(
                icon: Icons.remove,
                onPressed: () {
                  setState(() {
                    myShopper.decreaseNumber(counter);
                  });
                }),
            SizedBox(
              width: 20.0,
              child: TextField(
                controller: _itemNumberTextController[counter],
                onEditingComplete: () {
                  setState(() {
                    myShopper.setNumber(
                      counter,
                      int.parse(_itemNumberTextController[counter].text),
                    );
                    FocusScope.of(context).unfocus();
                  });
                },
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 10.0,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            _buildIconButton(
                icon: Icons.add,
                onPressed: () {
                  setState(() {
                    myShopper.increaseNumber(counter);
                  });
                }),
          ],
        )
      ],
    );
  }

  Widget _buildIconButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return IconButton(
      constraints: BoxConstraints.tight(const Size(35, 35)),
      icon: Icon(icon, size: 16.0, color: kRHIGGreen),
      onPressed: onPressed,
    );
  }

  Row _buildTotalRow() {
    return Row(
      children: [
        const BuildOutlinedButton(
          name: 'Continue Shopping',
          target: '/store',
          arguments: 'Dummy',
        ),
        const Expanded(child: SizedBox()),
        const Text('Total: '),
        Text(
          f.format(myShopper.getCartTotal()).toString(),
          style:
              const TextStyle(color: kRHIGGreen, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
