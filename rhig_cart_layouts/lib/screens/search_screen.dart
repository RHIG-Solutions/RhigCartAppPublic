import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

//TODO:Decide on behaviour when device is turned horizontal. If it overflows the page is useless anyway.
class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchTarget = TextEditingController();

  VendorTypeController myVendorTypes = VendorTypeController();
  VendorController myVendors = VendorController();

  @override
  Widget build(BuildContext context) {
    //Catches the logged in user from the Login Page
    final String _loggedInUser =
        ModalRoute.of(context)!.settings.arguments as String;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vendor Search'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: kSearchBarHeight / 5 * 3,
                    width: double.infinity,
                    color: kRHIGGreen,
                  ),
                  _buildSearchBar(context),
                ],
              ),
              //Draw box for Vendor Types scrollbar
              SizedBox(
                height: 70.0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: myVendorTypes.drawVendorTypes(),
                ),
              ),
              //TODO: Implement map functionality
              Flexible(
                child: Container(
                  color: const Color(0xFFDDDDAA),
                  width: double.infinity,
                  child: Center(
                    child: Stack(
                      children: [
                        const Center(child: Text('Map goes here')),
                        _buildNearbyVendorsScrollbar(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
      child: Material(
        elevation: kElevation,
        borderRadius: kInputFieldBorderRadius,
        color: Colors.white,
        child: SizedBox(
          height: kSearchBarHeight,
          width: double.infinity,
          child: TextField(
            controller: _searchTarget,
            decoration: InputDecoration(
              hintText: 'Search Vendor',
              border: InputBorder.none,
              prefixIcon: IconButton(
                onPressed: () {
                  //TODO: Add search bar functionality
                  Navigator.pushNamed(context, '/searchresult');
                },
                icon: const Icon(
                  Icons.search,
                  color: kRHIGGreen,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Align _buildNearbyVendorsScrollbar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      //Container to fade from map to Nearby Vendors bar
      child: Container(
        width: double.infinity,
        height: 170.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kBackgroundColour.withOpacity(0),
              kBackgroundColour.withOpacity(1),
            ],
          ),
        ),
        //color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: kMainEdgeMargin),
              child: Text(
                'Nearby Vendors',
                style: kGeneralBoldTextStyle,
              ),
            ),
            SizedBox(
              height: 140.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: myVendors.drawVendors(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VendorTypeController {
  List<VendorType> vendorTypes = [];
  final double _vendorTypeIconSize = 40.0;
  final int _vendorTypeCount = 10;
  VendorTypeController() {
    populate();
  }

  void populate() {
    //TODO: Populate list from web service, replacing dummy, alsop get typecount
    for (var counter = 0; counter < _vendorTypeCount; counter++) {
      vendorTypes.add(
        VendorType(
          iconImage: 'assets/images/test_image_2.png',
          type: 'Type ' + (counter + 1).toString(),
        ),
      );
    }
  }

  void filterByType() {
    //TODO: Apply filters, remove dummy print
    print('Apply filters');
  }

  Row drawVendorTypes() {
    return Row(
      children: [
        for (var counter = 0; counter < vendorTypes.length; counter++)
          Padding(
            padding: EdgeInsets.fromLTRB(
                counter == 0 ? kMainEdgeMargin : 25, 10, 0, 0),
            child: GestureDetector(
              onTap: () {
                filterByType();
              },
              child: Column(
                children: [
                  //Draw vendor type image
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(_vendorTypeIconSize / 2),
                    child: Image.asset(
                      vendorTypes[counter].iconImage,
                      width: _vendorTypeIconSize,
                      height: _vendorTypeIconSize,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  //Draw Vendor Type
                  Text(
                    vendorTypes[counter].type,
                    style: kNearbyVendorsBodyTextStyle,
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}

class VendorType {
  String iconImage;
  String type;
  VendorType({required this.iconImage, required this.type});
}

class VendorController {
  List<Vendor> vendors = [];
  final int _nearbyVendorCount = 10;
  VendorController() {
    _populate();
  }

  void _populate() {
    //TODO: Populate Vendor list from web source, replacing dummy, also get vendorcount
    for (var counter = 0; counter < _nearbyVendorCount; counter++) {
      vendors.add(
        Vendor(
            thumbNail: AssetImage('assets/images/test_image_1.png'),
            name: 'Vendor ' + (counter + 1).toString(),
            address: '123 Main Street, near church',
            phone: '+1 (234)-4567'),
      );
    }
  }

  Widget drawVendors(BuildContext context) {
    double _boxWidth = 130.0;
    return Row(
      children: [
        for (var counter = 0; counter < vendors.length; counter++)
          Padding(
            padding: EdgeInsets.fromLTRB(
                counter == 0 ? kMainEdgeMargin : 10, 2, 0, 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/store',
                    arguments: vendors[counter].name);
              },
              child: Material(
                elevation: kElevation,
                borderRadius: kInputFieldBorderRadius,
                child: Column(
                  children: [
                    Container(
                      height: 70.0,
                      width: _boxWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: vendors[counter].thumbNail,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(kInputFieldRadius),
                          topRight: Radius.circular(kInputFieldRadius),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vendors[counter].name,
                            textAlign: TextAlign.left,
                            style: kNearbyVendorsNameTextStyle,
                          ),
                          Text(
                            vendors[counter].address,
                            style: kNearbyVendorsBodyTextStyle,
                          ),
                          Text(
                            vendors[counter].phone,
                            style: kNearbyVendorsBodyTextStyle,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class Vendor {
  ImageProvider thumbNail;
  String name;
  String address;
  String phone;
  Vendor(
      {required this.thumbNail,
      required this.name,
      required this.address,
      required this.phone});
}
