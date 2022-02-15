import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/styles.dart';
import 'package:rhig_cart_layouts/constants.dart';

class VendorStoreScreen extends StatefulWidget {
  const VendorStoreScreen({Key? key}) : super(key: key);

  @override
  _VendorStoreScreenState createState() => _VendorStoreScreenState();
}

//TODO: Screen breaks when going horizontal
class _VendorStoreScreenState extends State<VendorStoreScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String _chosenVendor =
        ModalRoute.of(context)!.settings.arguments as String;
    final _VendorHomeController myCategories =
        _VendorHomeController(name: _chosenVendor);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildTitleBlock(myCategories),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    kMainEdgeMargin, 10, kMainEdgeMargin, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(context),
                    const SizedBox(height: 15.0),
                    const Text('All Product Categories',
                        style: kGeneralBoldTextStyle),
                    const SizedBox(height: 15.0),
                    //myCategories.listCategories(),
                  ],
                ),
              ),
              //Build Categories List
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: myCategories.drawCategories(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTitleBlock(_VendorHomeController myCategories) {
    return Container(
      width: double.infinity,
      color: kRHIGGreen,
      child: Stack(
        children: [
          const BackButton(color: Colors.white),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const SizedBox(height: 15.0),
                BuildBorderedRoundImage(
                  image: myCategories.image,
                  imageSize: 80,
                  borderWidth: 1.0,
                ),
                const SizedBox(height: 5.0),
                Text(
                  myCategories.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColour,
                  ),
                ),
                const SizedBox(height: 5.0),
                BuildStarRating(starRating: myCategories.starRating),
                const SizedBox(height: 5.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
                  child: Row(
                    children: [
                      const Icon(Icons.label, color: Colors.white),
                      //TODO: Sort out tags
                      const Text(
                        'Clothing',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: kBackgroundColour,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      _buildFavouriteButton(myCategories)
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
        ],
      ),
    );
  }

  ElevatedButton _buildFavouriteButton(_VendorHomeController myCategories) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          print(myCategories.isFavourite);
          myCategories.toggleFavourite();
        });
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 10.0),
        ),
      ),
      child: Row(
        children: [
          Icon(
              myCategories.isFavourite
                  ? Icons.remove_circle_outline
                  : Icons.add_circle_outline,
              color: kRHIGGreen,
              size: 20),
          Text(
              myCategories.isFavourite
                  ? 'Remove from Favourites'
                  : 'Add to Favourites',
              style: kSearchResultBodyTextStyle),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Material(
      elevation: kElevation,
      borderRadius: kInputFieldBorderRadius,
      color: Colors.white,
      child: SizedBox(
        height: kSearchBarHeight,
        width: double.infinity,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search product',
            border: InputBorder.none,
            prefixIcon: IconButton(
              onPressed: () {
                //TODO: Clarify what this search must do, and implement
                //Navigator.pushNamed(context, '/searchresult');
              },
              icon: const Icon(Icons.search, color: kRHIGGreen),
            ),
          ),
        ),
      ),
    );
  }
}

//Dummy Product Category list with drawing methods

class _VendorHomeController {
  ImageProvider image = const AssetImage('assets/images/image_missing.png');
  String name;
  double starRating = 0;
  bool isFavourite = false;
  List<_ProductCategory> categories = [];
  List<String> tags = [];
  final int _numberOfCategories = 9;

  _VendorHomeController({required this.name}) {
    _populate();
  }

  //TODO: Populate Vendor info off the web.
  _populate() {
    image = const AssetImage('assets/images/test_image_2.png');
    starRating = 2.5;
    isFavourite = true;
    tags.add('Clothing');
    tags.add('Casual');
    tags.add('Adult');
    tags.add('Male');
    for (var counter = 0; counter < _numberOfCategories; counter++) {
      categories.add(
        _ProductCategory(
          name: 'Category ' + (counter + 1).toString(),
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

  //TODO: There is a better way to display these items, look it up
  Column drawCategories(BuildContext context) {
    return Column(
      children: [
        for (var counter = 0;
            counter < categories.length;
            counter = counter + 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                BuildImageAndTextBox(
                  image: categories[counter].image,
                  text: Center(child: Text(categories[counter].name)),
                  target: () {
                    Navigator.pushNamed(context, '/productitem',
                        arguments: categories[counter].name);
                  },
                ),
                const SizedBox(width: 15.0),
                counter + 1 < categories.length
                    ? BuildImageAndTextBox(
                        image: categories[counter + 1].image,
                        text: Center(child: Text(categories[counter + 1].name)),
                        target: () {
                          Navigator.pushNamed(context, '/productitem',
                              arguments: categories[counter + 1].name);
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

class _ProductCategory {
  ImageProvider image;
  String name;

  _ProductCategory({required this.image, required this.name});
}
