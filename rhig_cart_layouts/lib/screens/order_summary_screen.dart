import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/constants.dart';
// import 'package:rhig_cart_layouts/styles.dart';
// import 'package:intl/intl.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
      ),
      bottomNavigationBar: Padding(
        padding: kBottomButtonPadding,
        child: BuildButton(
          title: 'Proceed to Payment',
          onPressed: () {},
        ),
      ),
    );
  }
}
