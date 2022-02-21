import 'package:flutter/cupertino.dart';
import 'grid_list_item_model.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/reusables.dart';

class Vendor {
  String name;
  ImageProvider image = const AssetImage('assets/images/image_missing.png');
  double starRating = 0;
  String description = '';
  bool isFavourite = false;
  List<String> tags = [];
  List<GridListItem> categories = [];

  //TODO: Currently working off the name as the main id.
  Vendor({required this.name}) {
    populate();
  }

  //TODO: Replace dummy populate with data off the server. no json implementation, as I have no idea of the server side data models
  void populate() {
    //Number of item categories the dummy must generate
    int numberOfCategories = 9;
    image = const AssetImage('assets/images/test_image_2.png');
    starRating = 2.5;
    isFavourite = true;
    description = 'Vendor description here';
    //TODO: Find out how tags are to be handled, doing 4 to test.
    for (var i = 0; i < 4; i++) {
      tags.add('Tag number ' + i.toString());
    }
    for (var counter = 0; counter < numberOfCategories; counter++) {
      categories.add(
        GridListItem(
          description: 'Category ' + (counter + 1).toString(),
          image: const AssetImage('assets/images/test_image_1.png'),
        ),
      );
    }
  }

  //TODO: Add functionality to change favourite status on the database
  toggleFavourite() {
    //Toggle does not work atm as the data is not updated in the database on
    //button press
    isFavourite = !isFavourite;
  }

  Widget drawCategories(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
        child: GridView.extent(
          maxCrossAxisExtent: 150.0,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
          children: [
            for (var counter = 0; counter < categories.length; counter++)
              BuildImageAndTextBox(
                  description: categories[counter].description,
                  image: categories[counter].image,
                  target: '/productitem'),
          ],
        ),
      ),
    );
  }
}
