import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/models.dart';
import 'package:rhig_cart_layouts/styles.dart';

Divider buildDividerLight() =>
    const Divider(thickness: 2.0, color: Color(0xFFEEEEEE));

class BuildOutlinedButton extends StatelessWidget {
  final String name;
  final String target;
  final String arguments;
  const BuildOutlinedButton(
      {Key? key, required this.name, required this.target, this.arguments = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, target, arguments: arguments);
        },
        child: Text(name),
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 12.0),
          onPrimary: kRHIGGreen,
          primary: Colors.white,
          fixedSize: const Size(
            double.infinity,
            kButtonHeight,
          ),
          side: const BorderSide(
            color: kRHIGGreen,
            width: 2.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              kButtonBorderRadius,
            ),
          ),
        ),
      ),
    );
  }
}

//Button builder
class BuildButton extends StatefulWidget {
  const BuildButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;
  @override
  _BuildButtonState createState() => _BuildButtonState();
}

class _BuildButtonState extends State<BuildButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: kMainEdgeMargin,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: widget.onPressed,
            child: Text(widget.title),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(
                double.infinity,
                kButtonHeight,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  kButtonBorderRadius,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: kMainEdgeMargin,
        ),
      ],
    );
  }
}

class BuildBorderedRoundImage extends StatelessWidget {
  final ImageProvider image;
  final double imageSize;
  final double borderWidth;
  final Color borderColour;
  const BuildBorderedRoundImage(
      {Key? key,
      required this.image,
      required this.imageSize,
      this.borderWidth = 2.0,
      this.borderColour = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: imageSize,
          height: imageSize,
          child: Material(
            color: borderColour,
            borderRadius: BorderRadius.all(
              Radius.circular(imageSize / 2),
            ),
          ),
        ),
        //Draw Image
        ClipRRect(
            borderRadius:
                BorderRadius.circular((imageSize - (borderWidth * 2)) / 2),
            child: Image(
              image: image,
              width: imageSize - borderWidth * 2,
              height: imageSize - borderWidth * 2,
            )),
      ],
    );
  }
}

class BuildStarRating extends StatelessWidget {
  final double _starSize = 18.0;
  final double starRating;
  final Color ratingColor;
  final List<Icon> stars = [];

  BuildStarRating(
      {Key? key, required this.starRating, this.ratingColor = Colors.white})
      : super(key: key) {
    for (var counter = 1; counter <= 5; counter++) {
      if (starRating >= counter) {
        stars.add(
          Icon(Icons.star, color: Colors.yellow, size: _starSize),
        );
      } else if (starRating - (counter - 1) == 0.5) {
        stars.add(
          Icon(Icons.star_half, color: Colors.yellow, size: _starSize),
        );
      } else {
        stars.add(
          Icon(Icons.star_border, color: Colors.yellow, size: _starSize),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var counter = 0; counter < stars.length; counter++) stars[counter],
        Text(
          '($starRating)',
          style: TextStyle(
            color: ratingColor,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

//TODO: Figure out how to display images correctly - use ClipRRect to shape
class BuildOldImageAndTextBox extends StatelessWidget {
  final ImageProvider image;
  final Widget text;
  final VoidCallback target;
  const BuildOldImageAndTextBox(
      {Key? key, required this.image, required this.text, required this.target})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: target,
        child: Material(
          color: Colors.white,
          elevation: kElevation,
          borderRadius: kInputFieldBorderRadius,
          child: SizedBox(
            height: 140.0,
            width: double.infinity,
            child: Column(
              children: [
                Image(
                  image: image,
                  height: 90.0,
                ),
                Flexible(child: text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildImageAndTextBox extends StatelessWidget {
  const BuildImageAndTextBox(
      {Key? key,
      required this.description,
      required this.image,
      required this.target})
      : super(key: key);
  final String target;
  final String description;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, target, arguments: description);
      },
      child: Material(
        elevation: kElevation,
        borderRadius: kInputFieldBorderRadius,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kInputFieldRadius),
                    topRight: Radius.circular(kInputFieldRadius),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(description),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//TODO:Decide on flex size or fixed size boxes, delete the following if flex
//----------
class Build2DGrid extends StatelessWidget {
  final List<GridListItem> myList;
  final String target;
  final double minPadding = 15.0;
  final double childheight = 100.0;
  final double childwidth = 130.0;
  const Build2DGrid({Key? key, required this.myList, required this.target})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Preparation calculations to get child numbers
    int numberOfChildrenPerRow;
    double spaceRemaining =
        MediaQuery.of(context).size.width - (kMainEdgeMargin * 2);
    for (numberOfChildrenPerRow = 0;
        spaceRemaining >= childwidth;
        numberOfChildrenPerRow++) {
      spaceRemaining = spaceRemaining - (childwidth + minPadding);
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMainEdgeMargin),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              for (var y = 0; y < myList.length; y = y + numberOfChildrenPerRow)
                Padding(
                  padding: EdgeInsets.only(bottom: minPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var x = 0; x < numberOfChildrenPerRow; x++)
                        x + y < myList.length
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, target,
                                      arguments: myList[x + y].description);
                                },
                                child: Material(
                                  elevation: kElevation,
                                  borderRadius: kInputFieldBorderRadius,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: childheight / 3 * 2,
                                        width: childwidth,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: myList[x + y].image,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(
                                                kInputFieldRadius),
                                            topRight: Radius.circular(
                                                kInputFieldRadius),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: childwidth,
                                        height: childheight / 3,
                                        child: Center(
                                          child:
                                              Text(myList[x + y].description),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(width: childwidth)
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

//----------
