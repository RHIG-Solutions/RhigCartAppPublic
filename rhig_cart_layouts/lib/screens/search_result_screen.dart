import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({Key? key}) : super(key: key);
  final _SearchResults _mySearchResults = _SearchResults();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
      ),
      body: _mySearchResults.displayResults(),
    );
  }
}

//Dummy search results class - copy out the disPlayResults method for the
//functionality. To change field size, padding and image border, use the
//appropriate properties of this class
class _SearchResults {
  final List<_SearchResultSpecifics> _resultList = [];
  final int _numberOfResults = 15;
  final double _resultFieldHeight = 80.0;
  final double _resultFieldPadding = 8.0;
  final double _imageBorderWidth = 3.0;

  _SearchResults() {
    for (var counter = 0; counter < _numberOfResults; counter++) {
      _resultList.add(
          _SearchResultSpecifics(name: 'Name ' + (counter + 1).toString()));
    }
  }
  Padding displayResults() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
      child: ListView(
        children: [
          for (var counter = 0; counter < _resultList.length; counter++)
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: counter == _resultList.length - 1 ? 20.0 : 0),
              //Create Result Boxes
              child: SizedBox(
                height: _resultFieldHeight,
                width: double.infinity,
                child: Material(
                  borderRadius: kInputFieldBorderRadius,
                  elevation: kElevation,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(_resultFieldPadding),
                    child: Row(
                      children: [
                        //Draw Image border
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width:
                                  _resultFieldHeight - _resultFieldPadding * 2,
                              height:
                                  _resultFieldHeight - _resultFieldPadding * 2,
                              child: Material(
                                color: kBackgroundColour,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(_resultFieldHeight -
                                      _resultFieldPadding * 2),
                                ),
                              ),
                            ),
                            //Draw Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  (_resultFieldHeight -
                                          (_resultFieldPadding * 2)) /
                                      2),
                              child: Image.asset(
                                _resultList[counter].image,
                                width: _resultFieldHeight -
                                    (_resultFieldPadding + _imageBorderWidth) *
                                        2,
                                height: _resultFieldHeight -
                                    (_resultFieldPadding + _imageBorderWidth) *
                                        2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: _resultFieldPadding),
                        //Draw Search Result Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _resultList[counter].name,
                                style: kSearchResultNameTextStyle,
                              ),
                              Text(
                                _resultList[counter].bodyText,
                                style: kSearchResultBodyTextStyle,
                              )
                            ],
                          ),
                        ),
                        //Draw Result IconButton
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: kRHIGGrey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

//Dummy Result specifics class
class _SearchResultSpecifics {
  String image = 'assets/images/test_image_2.png';
  String name;
  String bodyText = 'This is some body text';
  _SearchResultSpecifics({required this.name});
}
