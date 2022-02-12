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
  final double starRating = 1.5;
  final TextEditingController _searchController = TextEditingController();
  final _ProductCategories myCategories = _ProductCategories();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
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
                          const BuildBorderedRoundImage(
                            image: '/assets/images/test_image_2.png',
                            imageSize: 80,
                            borderWidth: 1.0,
                          ),
                          const SizedBox(height: 5.0),
                          Text('LUXURY CLOTHING', style: _storeNameTextStyle),
                          const SizedBox(height: 5.0),
                          BuildStarRating(starRating: starRating),
                          const SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kMainEdgeMargin),

                            //TODO: Find a tag icon, the one I found is pricey
                            child: Row(
                              children: [
                                const Icon(Icons.tag, color: Colors.white),
                                Text(
                                  'Clothing',
                                  style: _tagTextStyle,
                                ),
                                const Expanded(child: SizedBox()),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                    ),
                                  ),
                                  //TODO:Find heart icon
                                  child: Row(
                                    children: const [
                                      Icon(Icons.tag,
                                          color: kRHIGGreen, size: 20),
                                      Text(
                                        'Add to Favourites',
                                        style: kSearchResultBodyTextStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    kMainEdgeMargin, 10, kMainEdgeMargin, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
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
                                Navigator.pushNamed(context, '/searchresult');
                              },
                              icon: const Icon(Icons.search, color: kRHIGGreen),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const Text('All Product Categories',
                        style: kGeneralBoldTextStyle),
                    const SizedBox(height: 15.0),
                    //myCategories.listCategories(),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: myCategories.drawCategories(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle _storeNameTextStyle = const TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
  color: kBackgroundColour,
);

TextStyle _tagTextStyle = const TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.bold,
  color: kBackgroundColour,
);

//Dummy Product Category list with drawing methods

class _ProductCategories {
  List<_ProductCategorySpecifics> categories = [];
  final int _numberOfCategories = 9;
  _ProductCategories() {
    for (var counter = 0; counter < _numberOfCategories; counter++) {
      categories.add(
        _ProductCategorySpecifics(name: 'Category ' + (counter + 1).toString()),
      );
    }
  }
  Column drawCategories() {
    return Column(
      children: [
        for (var counter = 0;
            counter < categories.length;
            counter = counter + 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                _drawProductBox(
                    name: categories[counter].name,
                    image: categories[counter].image),
                const SizedBox(width: 15.0),
                counter + 1 < categories.length
                    ? _drawProductBox(
                        name: categories[counter + 1].name,
                        image: categories[counter + 1].image)
                    : const Expanded(child: SizedBox()),
              ],
            ),
          ),
      ],
    );
  }
}

//TODO: Figure out how to display images correctly - use ClipRRect to shape
Flexible _drawProductBox({required String name, required String image}) {
  return Flexible(
    child: Material(
      color: Colors.white,
      borderRadius: kInputFieldBorderRadius,
      child: SizedBox(
        height: 140.0,
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(
              image,
              height: 90.0,
            ),
            Flexible(child: Center(child: Text(name))),
          ],
        ),
      ),
    ),
  );
}

class _ProductCategorySpecifics {
  String image = 'assets/images/test_image_1.png';
  String name;
  _ProductCategorySpecifics({required this.name});
}
