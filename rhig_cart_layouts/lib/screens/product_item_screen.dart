import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/constants.dart';

class ProductItemScreen extends StatelessWidget {
  ProductItemScreen({Key? key}) : super(key: key);
  final _Products myProducts = _Products();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T-Shirts'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(kMainEdgeMargin, 10, kMainEdgeMargin, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: myProducts.drawProducts(context),
        ),
      ),
    );
  }
}

//Dummy Product list - includes the method to draw the product list
class _Products {
  final List<_ProductListSpecifics> _productList = [];
  final int _numberOfProducts = 13;
  _Products() {
    for (var counter = 0; counter < _numberOfProducts; counter++) {
      _productList.add(
        _ProductListSpecifics(name: 'Product ' + counter.toString()),
      );
    }
  }
  Column drawProducts(BuildContext context) {
    return Column(
      children: [
        for (var counter = 0;
            counter < _productList.length;
            counter = counter + 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                BuildImageAndTextBox(
                  image: _productList[counter].image,
                  text: Center(child: Text(_productList[counter].name)),
                  target: () {
                    Navigator.pushNamed(context, '/productdetails');
                  },
                ),
                const SizedBox(width: 15.0),
                counter + 1 < _productList.length
                    ? BuildImageAndTextBox(
                        image: _productList[counter + 1].image,
                        text:
                            Center(child: Text(_productList[counter + 1].name)),
                        target: () {
                          Navigator.pushNamed(context, '/productdetails');
                        },
                      )
                    : const Expanded(child: SizedBox()),
              ],
            ),
          ),
      ],
    );
  }
}

class _ProductListSpecifics {
  String image = 'assets/images/test_image_1.png';
  String name;
  _ProductListSpecifics({required this.name});
}
