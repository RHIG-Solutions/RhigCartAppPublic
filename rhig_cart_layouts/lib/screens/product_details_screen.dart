import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _chosenProduct =
        ModalRoute.of(context)!.settings.arguments as String;
    final _ProductController myProduct =
        _ProductController(name: _chosenProduct);

    return Scaffold(
      appBar: AppBar(
        title: Text(myProduct.name),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Image(
                image: myProduct.image,
                height: 200.0,
              ),
            ),
            _buildBodyTextBox(myProduct),
            const SizedBox(
              height: 15.0,
            ),
            _buildPricingAndStockBox(myProduct),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: kBottomButtonPadding,
        child: BuildButton(
            title: 'Add to Cart',
            onPressed: () {
              Navigator.pushNamed(context, '/mycart',
                  arguments: myProduct.name);
            }),
      ),
    );
  }

  SizedBox _buildBodyTextBox(_ProductController myProduct) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.white,
        elevation: kElevation,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              kMainEdgeMargin, 10.0, kMainEdgeMargin, 10),
          child: Text(
            myProduct.description,
            style: const TextStyle(
              color: kRHIGGrey,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Padding _buildPricingAndStockBox(_ProductController myProduct) {
    var f = NumberFormat.currency(symbol: '\$');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          borderRadius: kInputFieldBorderRadius,
          color: Colors.white,
          elevation: kElevation,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('PRICE'),
                    Text(
                      f.format(myProduct.price).toString(),
                      style: const TextStyle(
                        color: kRHIGGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('IN STOCK'),
                    Text(myProduct.inStock ? 'YES' : 'NO',
                        style: const TextStyle(color: kRHIGGreen)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductController {
  String name = '';
  ImageProvider image = const AssetImage('assets/images/image_missing.png');
  String description = '';
  double price = 0;
  bool inStock = false;
  _ProductController({required this.name}) {
    populate();
  }

  //TODO: Get product information off the server and replace dummy populate method
  void populate() {
    image = const AssetImage('assets/images/test_image_1.png');
    description =
        'Lorem ipsum dolor sit amet. Eos porro similique eos dolore quasi rem voluptatum illum cum quisquam illum qui dolorum aliquid. Eum facilis delectus quo iste eum deserunt maiores et natus expedita qui dolores debitis. Non ipsum molestias 33 cupiditate quas sed pariatur vitae aut beatae quas ea repudiandae dolores eum quas mollitia ut quidem quod. ';
    price = 20.50;
    inStock = true;
  }
}
