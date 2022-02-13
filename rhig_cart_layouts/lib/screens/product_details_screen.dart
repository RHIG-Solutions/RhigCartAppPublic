import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/test_image_1.png',
                height: 200.0,
              ),
            ),
            _buildBodyTextBox(),
            const SizedBox(
              height: 15.0,
            ),
            _buildPricingAndStockBox(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: kBottomButtonPadding,
        child: BuildButton(
            title: 'Add to Cart',
            onPressed: () {
              Navigator.pushNamed(context, '/mycart');
            }),
      ),
    );
  }

  SizedBox _buildBodyTextBox() {
    return const SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.white,
        elevation: kElevation,
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(kMainEdgeMargin, 10.0, kMainEdgeMargin, 10),
          child: Text(
            'Lorem ipsum dolor sit amet. Eos porro similique eos dolore quasi rem voluptatum illum cum quisquam illum qui dolorum aliquid. Eum facilis delectus quo iste eum deserunt maiores et natus expedita qui dolores debitis. Non ipsum molestias 33 cupiditate quas sed pariatur vitae aut beatae quas ea repudiandae dolores eum quas mollitia ut quidem quod. ',
            style: kProductDetailsBodyTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Padding _buildPricingAndStockBox() {
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
                  children: const [
                    Text('PRICE'),
                    Text('\$20.00', style: kPriceTextStyle)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('IN STOCK'),
                    Text('YES', style: TextStyle(color: kRHIGGreen)),
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
