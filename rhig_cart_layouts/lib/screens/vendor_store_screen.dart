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
  final TextStyle _vendorNameTextStyle = const TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    color: kBackgroundColour,
  );

  final TextStyle _vendorTagsTextStyle = const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: kBackgroundColour,
  );

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
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? _buildPortraitTitleBlock(myCategories)
                  : _buildLandscapeTitleBlock(myCategories),
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
              myCategories.drawCategories(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildPortraitTitleBlock(_VendorHomeController myCategories) {
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
                  style: _vendorNameTextStyle,
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
                      //TODO: Sort out tags, how many can there be?
                      Text('Clothing', style: _vendorTagsTextStyle),
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

  Container _buildLandscapeTitleBlock(_VendorHomeController myCategories) {
    //TODO: WIP, layout will change once decision is made on tags
    return Container(
      width: double.infinity,
      color: kRHIGGreen,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Stack(
            children: [
              const BackButton(color: Colors.white),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildBorderedRoundImage(
                    image: myCategories.image,
                    imageSize: 80,
                    borderWidth: 1.0,
                  ),
                  const SizedBox(width: 15.0),
                  Column(
                    children: [
                      Text(
                        myCategories.name.toUpperCase(),
                        style: _vendorNameTextStyle,
                      ),
                      const SizedBox(height: 5.0),
                      BuildStarRating(starRating: myCategories.starRating),
                    ],
                  ),
                  const SizedBox(width: 15.0),
                  const Icon(Icons.label, color: Colors.white),
                  //TODO: Sort out tags
                  Text('Clothing', style: _vendorTagsTextStyle),
                  const SizedBox(width: 15.0),
                  _buildFavouriteButton(myCategories)
                ],
              ),
            ],
          )),
    );
  }

  ElevatedButton _buildFavouriteButton(_VendorHomeController myCategories) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
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
  List<GridListItem> categories = [];
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
    //TODO: Decide on fixed vs flex boxes, switch to the following if fixed is chosen(remember to do reusables as well)
    // return Build2DGrid(
    //   myList: categories,
    //   target: '/productitem',
    // );
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
