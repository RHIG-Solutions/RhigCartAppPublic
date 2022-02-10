import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //TODO: Add proper field value handling including disposal etc.

  //Creates the main OTP object. The OTP Final product is created in the
  //finalize method and stored as myOTP.oTP after Done is pressed
  OTPController myOTP = OTPController(numberOfFields: 4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Fill in an OTP to reset password'),
          const SizedBox(height: 30.0),
          //Row of 4 OTP Fields
          _buildOTPFields(context),
          const SizedBox(height: 40.0),
          //TODO: Implement Resend button functionality
          _buildResendButton()
        ],
      ),
    );
  }

  Row _buildOTPFields(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        drawOTPField(
          child: TextField(
            focusNode: myOTP.field[0].node,
            controller: myOTP.field[0].textController,
            onTap: () {
              setState(() {
                myOTP.tapped(0);
              });
            },
            onChanged: (value) {
              setState(() {
                myOTP.changed(value);
                FocusScope.of(context)
                    .requestFocus(myOTP.field[myOTP.activeNode].node);
              });
            },
            textInputAction: TextInputAction.next,
            autofocus: true,
            style: kOTPFieldTextStyle,
            decoration: kOTPFieldDecoration,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        drawOTPField(
          child: TextField(
            focusNode: myOTP.field[1].node,
            controller: myOTP.field[1].textController,
            onTap: () {
              setState(() {
                myOTP.tapped(1);
              });
            },
            onChanged: (value) {
              setState(() {
                myOTP.changed(value);
                FocusScope.of(context)
                    .requestFocus(myOTP.field[myOTP.activeNode].node);
              });
            },
            textInputAction: TextInputAction.next,
            style: kOTPFieldTextStyle,
            decoration: kOTPFieldDecoration,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        drawOTPField(
          child: TextField(
            focusNode: myOTP.field[2].node,
            controller: myOTP.field[2].textController,
            onTap: () {
              setState(() {
                myOTP.tapped(2);
              });
            },
            onChanged: (value) {
              setState(() {
                myOTP.changed(value);
                FocusScope.of(context)
                    .requestFocus(myOTP.field[myOTP.activeNode].node);
              });
            },
            textInputAction: TextInputAction.next,
            style: kOTPFieldTextStyle,
            decoration: kOTPFieldDecoration,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        drawOTPField(
          child: TextField(
            focusNode: myOTP.field[3].node,
            controller: myOTP.field[3].textController,
            onTap: () {
              setState(() {
                myOTP.tapped(3);
              });
            },
            onChanged: (value) {
              setState(() {
                myOTP.changed(value);
                FocusScope.of(context)
                    .requestFocus(myOTP.field[myOTP.activeNode].node);
              });
            },
            onEditingComplete: () {
              myOTP.finalize();
              //TODO: setup actions after done is pressed. Currently it just pops this screen off
              Navigator.pop(context);
            },
            textInputAction: TextInputAction.done,
            style: kOTPFieldTextStyle,
            decoration: kOTPFieldDecoration,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
      ],
    );
  }
}

TextButton _buildResendButton() {
  return TextButton(
    onPressed: () {},
    child: const Text(
      'Resend',
      style: TextStyle(
        color: Colors.grey,
      ),
    ),
  );
}

// class that manages OTP field values and interactions
class OTPController {
  int numberOfFields;
  int activeNode = 0;
  String oTP = '';
  List<OTPFieldProperties> field = [];

  OTPController({required this.numberOfFields}) {
    for (var counter = 0; counter < numberOfFields; counter++) {
      field.add(OTPFieldProperties());
    }
  }
  void tapped(int tappedNode) {
    activeNode = tappedNode;
  }

  //Method that keeps the latest digit entered into a field and manages field
  //reactions when a change occurs
  void changed(String value) {
    if (value.length > 1) {
      field[activeNode].textController.text =
          value.replaceAll(field[activeNode].oldValue, '');
      if (field[activeNode].textController.text.isEmpty) {
        field[activeNode].textController.text = field[activeNode].oldValue;
      }
    }
    field[activeNode].oldValue = field[activeNode].textController.text;
    if (field[activeNode].textController.text.isNotEmpty) {
      _nextNode();
    }
  }

  void finalize() {
    oTP = '';
    for (var counter = 0; counter < numberOfFields; counter++) {
      oTP = oTP + field[counter].textController.text;
    }
  }

  int _nextNode() {
    if (activeNode < 3) {
      activeNode++;
    }
    return activeNode;
  }
}

//OTP Field specific Properties
class OTPFieldProperties {
  FocusNode node = FocusNode();
  TextEditingController textController = TextEditingController();
  String oldValue = '';
}

//Draws OTP Fields on screen
Container drawOTPField({TextField child = const TextField()}) {
  return Container(
    width: 55.0,
    height: 65.0,
    margin: const EdgeInsets.symmetric(horizontal: 3.0),
    child: Material(
      color: Colors.white,
      elevation: kElevation,
      borderRadius: kInputFieldBorderRadius,
      child: Center(
        child: child,
      ),
    ),
  );
}

//OTP Input field size and shape specifics
const InputDecoration kOTPFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.only(left: 20.0),
  border: InputBorder.none,
);
