import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchTarget = TextEditingController();

  //Temporary Vendor DBs for design purposes
  VendorTypeList myVendorTypes = VendorTypeList();
  VendorList myVendors = VendorList();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
                    child: Material(
                      elevation: kElevation,
                      borderRadius: kInputFieldBorderRadius,
                      color: Colors.white,
                      child: Container(
                        height: kSearchBarHeight,
                        width: double.infinity,
                        child: TextField(
                          controller: _searchTarget,
                          decoration: InputDecoration(
                            hintText: 'Search Vendor',
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: () {
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
                  ),
                ],
              ),
              Container(
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
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            height: 170.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  kBackgroundColour.withOpacity(0.0),
                                  kBackgroundColour.withOpacity(1),
                                ],
                              ),
                            ),
                            //color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: kMainEdgeMargin),
                                  child: Text(
                                    'Nearby Vendors',
                                    style: kGeneralBoldTextStyle,
                                  ),
                                ),
                                Container(
                                  height: 140.0,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: myVendors.drawVendors(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
}

//TODO: Replace temporary Vendor lists with actual database access
class VendorTypeList {
  List<VendorTypes> vendorTypes = [];
  final double _vendorTypeIconSize = 40.0;
  VendorTypeList() {
    for (var counter = 0; counter < 10; counter++) {
      vendorTypes.add(
        VendorTypes(
          iconImage: 'assets/images/test_image_2.png',
          name: 'Type ' + (counter + 1).toString(),
        ),
      );
    }
  }
  Row drawVendorTypes() {
    return Row(
      children: [
        for (var counter = 0; counter < vendorTypes.length; counter++)
          Padding(
            padding: EdgeInsets.fromLTRB(
                counter == 0 ? kMainEdgeMargin : 25, 10, 0, 0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(_vendorTypeIconSize / 2),
                  child: Image.asset(
                    vendorTypes[counter].iconImage,
                    width: _vendorTypeIconSize,
                    height: _vendorTypeIconSize,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  vendorTypes[counter].name,
                  style: kNearbyVendorsBodyTextStyle,
                ),
              ],
            ),
          )
      ],
    );
  }
}

class VendorTypes {
  String iconImage;
  String name;
  VendorTypes({required this.iconImage, required this.name});
}

class VendorList {
  List<Vendors> vendors = [];
  VendorList() {
    for (var counter = 0; counter < 10; counter++) {
      vendors.add(
        Vendors(name: 'Name ' + (counter + 1).toString()),
      );
    }
  }
  //TODO Vendor Draw spacing is very inflexible and inelegant, sort it out.
  Row drawVendors(BuildContext context) {
    return Row(
      children: [
        for (var counter = 0; counter < vendors.length; counter++)
          Padding(
            padding: EdgeInsets.fromLTRB(
                counter == 0 ? kMainEdgeMargin : 10, 2, 0, 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/store');
              },
              child: SizedBox(
                width: 130.0,
                height: double.infinity,
                child: Material(
                  elevation: kElevation,
                  borderRadius: BorderRadius.circular(kInputFieldRadius),
                  child: Column(
                    children: [
                      //TODO: Figure out how to display image properly
                      ClipRRect(
                        child: Image.asset(
                          vendors[counter].thumbNail,
                          fit: BoxFit.fill,
                          height: 70.0,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(kInputFieldRadius),
                          topRight: Radius.circular(kInputFieldRadius),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class Vendors {
  String thumbNail = 'assets/images/test_image_1.png';
  String name;
  String address = '123 main street, near church';
  String phone = '+1 (234)-5678';
  Vendors({required this.name});
}
