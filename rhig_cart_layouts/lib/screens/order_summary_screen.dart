import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/models.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';
import 'package:intl/intl.dart';

class OrderSummaryScreen extends StatelessWidget {
  OrderSummaryScreen({Key? key}) : super(key: key);

  final f = NumberFormat.currency(symbol: '\$');
  //TODO: I am  a bit lost with the current data setup. just making dummy sets for now
  final ShopperModel myShopper = ShopperModel(id: 'Dummy');
  final VendorModel myVendor = VendorModel(name: 'Dummy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildTitleBlock(),
            const SizedBox(height: 20.0),
            _buildCartSummaryBlock(context),
            const SizedBox(height: 20.0),
            _buildDeliveryMethodBlock(context),
            const SizedBox(height: 20.0),
          ],
        ),
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

  SizedBox _buildTitleBlock() {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: kElevation,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15.0),
              BuildBorderedRoundImage(image: myVendor.image, imageSize: 80.0),
              const SizedBox(height: 5.0),
              Text(
                myVendor.name,
                style: const TextStyle(
                    color: kRHIGGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              Text(
                myVendor.description,
                style: kSummaryBodyTextStyle,
              ),
              const SizedBox(height: 5.0),
              BuildStarRating(
                  starRating: myVendor.starRating, ratingColor: kRHIGGrey),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildCartSummaryBlock(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: kElevation,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(myShopper.countItems().toString() + ' items'),
                  Text(
                    f.format(myShopper.totalCost).toString(),
                    style: const TextStyle(color: kRHIGGreen),
                  ),
                ],
              ),
              buildDividerLight(),
              for (var i = 0; i < myShopper.cart.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      myShopper.cart[i].item,
                      style: kSummaryBodyTextStyle,
                    ),
                    Text(
                      myShopper.cart[i].numberOfItems.toString(),
                      style: kSummaryBodyTextStyle,
                    ),
                  ],
                ),
              buildDividerLight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TO PAY',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    f.format(myShopper.totalCost).toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: kRHIGGreen),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: const [
                  Expanded(child: SizedBox()),
                  BuildOutlinedButton(name: 'Edit my Cart', target: '/mycart'),
                ],
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildDeliveryMethodBlock(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        elevation: kElevation,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kMainEdgeMargin, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Delivery Method'),
                  Row(
                    children: [
                      const Icon(
                        Icons.done,
                        color: kRHIGGreen,
                        size: 18.0,
                      ),
                      Text(
                        ' ' + myShopper.getDeliveryMethod(),
                        style: const TextStyle(color: kRHIGGreen),
                      ),
                    ],
                  )
                ],
              ),
              const BuildOutlinedButton(
                  name: 'Change', target: '/deliverymethod'),
            ],
          ),
        ),
      ),
    );
  }
}
