import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';

class DeliveryMethodScreen extends StatefulWidget {
  const DeliveryMethodScreen({Key? key}) : super(key: key);

  @override
  _DeliveryMethodScreenState createState() => _DeliveryMethodScreenState();
}

enum DeliveryMethod { door2door, pickup, collect }

class _DeliveryMethodScreenState extends State<DeliveryMethodScreen> {
  DeliveryMethod? _deliveryMethod = DeliveryMethod.door2door;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Method'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Material(
                color: Colors.white,
                elevation: kElevation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(left: kMainEdgeMargin, bottom: 5.0),
                        child: Text(
                          'Please choose a delivery method',
                          style: kGeneralBoldTextStyle,
                        ),
                      ),
                      buildRadioButton(
                          title: 'Door-to-Door Delivery',
                          method: DeliveryMethod.door2door),
                      buildRadioButton(
                          title: 'Pickup', method: DeliveryMethod.pickup),
                      buildRadioButton(
                          title: 'Collect', method: DeliveryMethod.collect),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: kBottomButtonPadding,
        child: BuildButton(
          title: 'Order Summary',
          onPressed: () {
            Navigator.pushNamed(context, '/ordersummary');
          },
        ),
      ),
    );
  }

  Padding buildRadioButton(
      {required String title, required DeliveryMethod method}) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainEdgeMargin - 10),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 14.0, color: kRHIGGrey),
        ),
        contentPadding: const EdgeInsets.all(0),
        leading: Transform.scale(
          scale: 1.3,
          child: Radio<DeliveryMethod>(
            value: method,
            groupValue: _deliveryMethod,
            onChanged: (DeliveryMethod? value) {
              setState(() {
                _deliveryMethod = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
