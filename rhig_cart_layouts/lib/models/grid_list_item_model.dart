import 'package:flutter/cupertino.dart';

//Class for grid view items.
//I don't know how this data will be coming from the server, so I am not adding
//any json functionality to the class for now.

class GridListItem {
  ImageProvider image;
  String description;
  GridListItem({required this.image, required this.description});
}
