import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/styles.dart';
import 'constants.dart';

//Divider builder
class BuildDivider {
  // bool isIndented;
  // BuildDivider({this.isIndented = true});
  Divider draw({bool isIndented = true}) {
    return Divider(
      indent: isIndented ? kMainEdgeMargin : 0,
      endIndent: isIndented ? kMainEdgeMargin : 0,
      thickness: 2.0,
      color: kDividerAndUnderlineColour,
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
  final String image;
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
          child: Image.asset(
            'assets/images/test_image_2.png',
            width: imageSize - borderWidth * 2,
            height: imageSize - borderWidth * 2,
          ),
        ),
      ],
    );
  }
}

//TODO: Find a way to have half white stars and white stars as empty
class BuildStarRating extends StatelessWidget {
  final double _starSize = 18.0;
  final double starRating;
  final List<Icon> stars = [];
  BuildStarRating({Key? key, required this.starRating}) : super(key: key) {
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
        Text('($starRating)', style: kStarRatingTextStyle),
      ],
    );
  }
}

//TODO: Figure out how to display images correctly - use ClipRRect to shape
class BuildImageAndTextBox extends StatelessWidget {
  final String image;
  final Widget text;
  final VoidCallback target;
  const BuildImageAndTextBox(
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
                Image.asset(
                  image,
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
