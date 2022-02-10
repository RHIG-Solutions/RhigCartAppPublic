import 'package:flutter/material.dart';
import 'constants.dart';

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
