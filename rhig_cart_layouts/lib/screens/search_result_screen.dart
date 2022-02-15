import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/reusables.dart';
import 'package:rhig_cart_layouts/styles.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({Key? key}) : super(key: key);
  final _SearchResultController _mySearchResults = _SearchResultController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
      ),
      body: _mySearchResults.displayResults(context),
    );
  }
}

class _SearchResultController {
  final double _resultFieldHeight = 80.0;
  final double _resultFieldPadding = 8.0;
  final double _imageBorderWidth = 2.0;

  final List<_SearchResult> _resultList = [];
  final int _numberOfResults = 15;
  _SearchResultController() {
    populate();
  }
  void populate() {
    //TODO: Populate search results off the web, and replace dummy populator
    for (var counter = 0; counter < _numberOfResults; counter++) {
      _resultList.add(_SearchResult(
          image: const AssetImage('assets/images/test_image_2.png'),
          name: 'Result ' + (counter + 1).toString(),
          bodyText: 'This is some body text'));
    }
  }

  Padding displayResults(BuildContext context) {
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
                        BuildBorderedRoundImage(
                          image: _resultList[counter].image,
                          imageSize:
                              _resultFieldHeight - _resultFieldPadding * 2,
                          borderWidth: _imageBorderWidth,
                          borderColour: kBackgroundColour,
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
                          onPressed: () => Navigator.pushNamed(
                              context, '/store',
                              arguments: _resultList[counter].name),
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

class _SearchResult {
  ImageProvider image;
  String name;
  String bodyText;
  _SearchResult(
      {required this.image, required this.name, required this.bodyText});
}
