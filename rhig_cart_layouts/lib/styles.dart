import 'package:flutter/material.dart';

//Colours.
const kRHIGGreen = Color(0xFF9FC51A);
const kSelection = Color(0x779FC51A);
const kRHIGGrey = Color(0xFF686868);
const kBackgroundColour = Color(0xFFE7E7E7);
const kSloganColour = Color(0xFF777777);
const kShadowColour = Color(0xFFFFFFFF);
const kDividerAndUnderlineColour = Color(0xFFDDDDDD);

//Text Styles
const kMainTitleTextStyle = TextStyle(
  fontSize: 22.0,
  color: kRHIGGreen,
  fontWeight: FontWeight.bold,
);

//TODO: Decide on label text styles. Currently not the same across pages.
//Each page is currently being defined on that page, if a unified size can be
//decided upon, move it to Theme.

const kLoginFieldLabelTextStyle = TextStyle(
  fontSize: 17.0,
  color: kRHIGGreen,
);

const kRegistrationFieldLabelTextStyle = TextStyle(
  fontSize: 13.0,
  color: kRHIGGreen,
);

const kSloganTextStyle = TextStyle(
  fontSize: 14.0,
);

const kAppBarTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: kBackgroundColour,
);

const kOTPFieldTextStyle = TextStyle(
  color: kRHIGGrey,
  fontSize: 23.0,
);

const kGeneralBoldTextStyle = TextStyle(
  color: kRHIGGrey,
  fontSize: 13.0,
  fontWeight: FontWeight.bold,
);

const kNearbyVendorsNameTextStyle = TextStyle(
  color: kRHIGGreen,
  fontSize: 12.0,
  fontWeight: FontWeight.bold,
);

const kNearbyVendorsBodyTextStyle = TextStyle(
  color: kRHIGGrey,
  fontSize: 6.5,
  fontWeight: FontWeight.bold,
);
const kSearchResultNameTextStyle = TextStyle(
  color: kRHIGGreen,
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
);

const kSearchResultBodyTextStyle = TextStyle(
  color: kRHIGGrey,
  fontSize: 8,
  fontWeight: FontWeight.bold,
);

const kStarRatingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 10,
);
