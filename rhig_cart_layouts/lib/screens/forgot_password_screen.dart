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
  final OTPController _myOTP = OTPController(numberOfFields: 4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Fill in an OTP to reset password'),
            const SizedBox(height: 30.0),
            //Row of 4 OTP Fields
            _buildOTPFields(context),
            const SizedBox(height: 20.0),
            Text(
              _myOTP._isIncorrect ? 'OTP Incorrect' : '',
              style: const TextStyle(color: Colors.red),
            ),
            _buildResendButton()
          ],
        ),
      ),
    );
  }

  Row _buildOTPFields(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        drawOTPField(
          child: TextField(
            focusNode: _myOTP.field[0].node,
            controller: _myOTP.field[0].textController,
            onTap: () {
              setState(() {
                _myOTP._tapped(0);
              });
            },
            onChanged: (value) {
              setState(() {
                _myOTP._changed(value);
                FocusScope.of(context)
                    .requestFocus(_myOTP.field[_myOTP._activeNode].node);
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
            focusNode: _myOTP.field[1].node,
            controller: _myOTP.field[1].textController,
            onTap: () {
              setState(() {
                _myOTP._tapped(1);
              });
            },
            onChanged: (value) {
              setState(() {
                _myOTP._changed(value);
                FocusScope.of(context)
                    .requestFocus(_myOTP.field[_myOTP._activeNode].node);
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
            focusNode: _myOTP.field[2].node,
            controller: _myOTP.field[2].textController,
            onTap: () {
              setState(() {
                _myOTP._tapped(2);
              });
            },
            onChanged: (value) {
              setState(() {
                _myOTP._changed(value);
                FocusScope.of(context)
                    .requestFocus(_myOTP.field[_myOTP._activeNode].node);
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
            focusNode: _myOTP.field[3].node,
            controller: _myOTP.field[3].textController,
            onTap: () {
              setState(() {
                _myOTP._tapped(3);
              });
            },
            onChanged: (value) {
              setState(() {
                _myOTP._changed(value);
                FocusScope.of(context)
                    .requestFocus(_myOTP.field[_myOTP._activeNode].node);
              });
            },
            onEditingComplete: () {
              setState(() {
                if (_myOTP._isCorrect()) {
                  //TODO: setup actions after correct OTP entry. Currently it just pops this screen off
                  Navigator.pop(context);
                } else {
                  FocusScope.of(context)
                      .requestFocus(_myOTP.field[_myOTP._activeNode].node);
                }
              });
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

  TextButton _buildResendButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          _myOTP._resend();
          _myOTP._reset();
          FocusScope.of(context)
              .requestFocus(_myOTP.field[_myOTP._activeNode].node);
        });
      },
      child: const Text(
        'Resend',
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
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
  InputDecoration kOTPFieldDecoration = const InputDecoration(
    contentPadding: EdgeInsets.only(left: 20.0),
    border: InputBorder.none,
  );
}

// class that manages OTP field values and interactions
class OTPController {
  bool _isIncorrect = false;
  int numberOfFields;
  int _activeNode = 0;
  String _oTP = '';
  List<OTPFieldProperties> field = [];

  OTPController({required this.numberOfFields}) {
    for (var counter = 0; counter < numberOfFields; counter++) {
      field.add(OTPFieldProperties());
    }
  }
  void _tapped(int tappedNode) {
    _activeNode = tappedNode;
  }

  //Method that keeps the latest digit entered into a field and manages field
  //reactions when a change occurs
  void _changed(String value) {
    if (value.length > 1) {
      field[_activeNode].textController.text =
          value.replaceAll(field[_activeNode].oldValue, '');
      if (field[_activeNode].textController.text.isEmpty) {
        field[_activeNode].textController.text = field[_activeNode].oldValue;
      }
    }
    field[_activeNode].oldValue = field[_activeNode].textController.text;
    if (field[_activeNode].textController.text.isNotEmpty) {
      _nextNode();
    }
  }

  bool _isCorrect() {
    _oTP = '';
    for (var counter = 0; counter < numberOfFields; counter++) {
      _oTP = _oTP + field[counter].textController.text;
    }
    //TODO:Add real OTP check, replacing dummy, and add functionality.
    if (_oTP == '1234') {
      _isIncorrect = false;
      return true;
    } else {
      _isIncorrect = true;
      _reset();
      return false;
    }
  }

  void _resend() {
    //TODO: Add resend button functionality
  }

  void _reset() {
    for (var counter = 0; counter < field.length; counter++) {
      field[counter].textController.text = '';
    }
    _tapped(0);
  }

  int _nextNode() {
    if (_activeNode < 3) {
      _activeNode++;
    }
    return _activeNode;
  }
}

//OTP Field specific Properties
class OTPFieldProperties {
  FocusNode node = FocusNode();
  TextEditingController textController = TextEditingController();
  String oldValue = '';
}
