import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/constants.dart';

class ProductItemScreen extends StatelessWidget {
  const ProductItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _chosenCategory =
        ModalRoute.of(context)!.settings.arguments as String;
    final _ProductController myProducts =
        _ProductController(category: _chosenCategory);

    return Scaffold(
      appBar: AppBar(
        title: Text(myProducts.category),
      ),
      body: Padding(
        padding:
            const EdgeInsets.fromLTRB(kMainEdgeMargin, 10, kMainEdgeMargin, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: myProducts.drawProducts(context),
        ),
      ),
    );
  }
}

class _ProductController {
  final String category;
  final List<_Product> _productList = [];
  final int _numberOfProducts = 13;
  _ProductController({required this.category}) {
    populate();
  }

  //TODO: Get product info off web, and replace dummy population method
  void populate() {
    for (var counter = 0; counter < _numberOfProducts; counter++) {
      _productList.add(
        _Product(
            name: 'Product ' + counter.toString(),
            image: const AssetImage('assets/images/test_image_1.png')),
      );
    }
  }

  //TODO: There is a better way to draw the products, look it up(same as categories)
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
                    Navigator.pushNamed(context, '/productdetails',
                        arguments: _productList[counter].name);
                  },
                ),
                const SizedBox(width: 15.0),
                counter + 1 < _productList.length
                    ? BuildImageAndTextBox(
                        image: _productList[counter + 1].image,
                        text:
                            Center(child: Text(_productList[counter + 1].name)),
                        target: () {
                          Navigator.pushNamed(context, '/productdetails',
                              arguments: _productList[counter + 1].name);
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

class _Product {
  ImageProvider image;
  String name;
  _Product({required this.image, required this.name});
}
