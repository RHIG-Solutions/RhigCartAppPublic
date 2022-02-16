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
      body: myProducts.drawProducts(context),
    );
  }
}

class _ProductController {
  final String category;
  final List<GridListItem> _productList = [];
  final int _numberOfProducts = 13;
  _ProductController({required this.category}) {
    populate();
  }

  //TODO: Get product info off web, and replace dummy population method
  void populate() {
    for (var counter = 0; counter < _numberOfProducts; counter++) {
      _productList.add(
        GridListItem(
            description: 'Product ' + (counter + 1).toString(),
            image: const AssetImage('assets/images/test_image_1.png')),
      );
    }
  }

  Widget drawProducts(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kMainEdgeMargin, top: 15.0, right: kMainEdgeMargin),
      child: GridView.extent(
        maxCrossAxisExtent: 150.0,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        children: [
          for (var counter = 0; counter < _productList.length; counter++)
            BuildImageAndTextBox(
                description: _productList[counter].description,
                image: _productList[counter].image,
                target: '/productdetails'),
        ],
      ),
    );
  }
}
