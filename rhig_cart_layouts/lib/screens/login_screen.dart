import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';
import 'package:rhig_cart_layouts/reusables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //TODO: Verify if TextControllers need disposal.

  //----------
  //Username and password field specs
  static const BorderRadiusGeometry _kInputFieldBorderRadius =
      BorderRadius.only(
    topRight: Radius.circular(kInputFieldRadius),
    bottomRight: Radius.circular(kInputFieldRadius),
  );

  static const EdgeInsetsGeometry _kFieldContentPadding = EdgeInsets.symmetric(
    horizontal: kMainEdgeMargin,
    vertical: 10.0,
  );
  //----------

  final _LoginProperties _myLogin = _LoginProperties();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20.0),
                        Image.asset('assets/images/logo.png', height: 120.0),
                        const Text(
                          'APP FULL NAME',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: kRHIGGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Slogan Here',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 15.0),
                        //Notes for Login Screen Form: Wrapped the TextFormFields in Focus
                        //widgets to allow for the reliable background and elevation changes
                        //upon focus changes, this broke the auto keyboard display upon next
                        //field selection on keyboard. Used requestFocus to resolve this.
                        Form(
                          key: _myLogin._key,
                          child: Column(
                            children: [
                              _buildUsernameTextField(context),
                              const SizedBox(height: 15.0),
                              _buildPasswordTextField(context),
                            ],
                          ),
                        ),
                        _buildDivider(),
                        _buildForgotPasswordButton(),
                        const SizedBox(height: 10.0),
                        //Build Login ElevatedButton
                        BuildButton(
                            title: 'Login',
                            onPressed: () {
                              setState(() {
                                _myLogin.loginSuccessful()
                                    ? Navigator.pushNamed(context, '/search',
                                        arguments: _myLogin.loggedInAccount)
                                    : FocusScope.of(context)
                                        .requestFocus(_myLogin._usernameNode);
                              });
                            }),
                        Expanded(child: Container(height: 15.0)),
                        _buildDivider(),
                        const SizedBox(height: 20.0),
                        _buildCreateAccountButton(),
                        const SizedBox(height: kBottomMargin),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  //Divider builder
  Divider _buildDivider() => const Divider(
        thickness: 2.0,
        color: Color(0xFFDDDDDD),
        indent: kMainEdgeMargin,
        endIndent: kMainEdgeMargin,
      );

  //"Username" TextField builder
  Row _buildUsernameTextField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            color: _myLogin._usernameFieldLooks._colour,
            elevation: _myLogin._usernameFieldLooks._elevation,
            borderRadius: _kInputFieldBorderRadius,
            child: Focus(
              child: TextFormField(
                focusNode: _myLogin._usernameNode,
                textInputAction: TextInputAction.next,
                controller: _myLogin._usernameController,
                enableSuggestions: false,
                onFieldSubmitted: (value) {
                  _myLogin._usernameController.text = value.toString();
                  //The following line activates the keyboard for the next field when pressing the
                  //next button in the current field, the default TextInputAction stopped working
                  //after adding the Focus widget
                  FocusScope.of(context).requestFocus(_myLogin._passwordNode);
                },
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  contentPadding: _kFieldContentPadding,
                  border: InputBorder.none,
                  labelText: 'Username',
                  //TODO: Add username icon functionality (remove const)
                  labelStyle: kLoginFieldLabelTextStyle,
                  suffixIcon: const Icon(
                    CupertinoIcons.check_mark,
                    size: 18.0,
                    color: kRHIGGreen,
                  ),
                  errorText:
                      _myLogin.failed ? 'Username or Password incorrect' : null,
                ),
              ),
              onFocusChange: (hasFocus) {
                setState(() {
                  hasFocus
                      ? _myLogin._usernameFieldLooks.isFocused()
                      : _myLogin._usernameFieldLooks.isUnfocused();
                });
              },
            ),
          ),
        ),
        const SizedBox(width: kMainEdgeMargin),
      ],
    );
  }

  //"Password" TextField builder
  Row _buildPasswordTextField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            color: _myLogin._passwordFieldLooks._colour,
            elevation: _myLogin._passwordFieldLooks._elevation,
            borderRadius: _kInputFieldBorderRadius,
            child: Focus(
              child: TextFormField(
                focusNode: _myLogin._passwordNode,
                textInputAction: TextInputAction.done,
                controller: _myLogin._passwordController,
                enableSuggestions: false,
                obscureText: _myLogin._passwordObscured,
                obscuringCharacter: '*',
                onFieldSubmitted: (value) {
                  setState(() {
                    _myLogin._passwordController.text = value.toString();
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  contentPadding: _kFieldContentPadding,
                  border: InputBorder.none,
                  labelText: 'Password',
                  labelStyle: kLoginFieldLabelTextStyle,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _myLogin._passwordObscured =
                            !_myLogin._passwordObscured;
                      });
                    },
                    icon: Icon(
                      _myLogin._passwordObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              onFocusChange: (hasFocus) {
                setState(() {
                  hasFocus
                      ? _myLogin._passwordFieldLooks.isFocused()
                      : _myLogin._passwordFieldLooks.isUnfocused();
                });
              },
            ),
          ),
        ),
        const SizedBox(width: kMainEdgeMargin),
      ],
    );
  }

  //TODO: Figure out forgot password position issues
  // "Forgot password" button builder
  SizedBox _buildForgotPasswordButton() {
    return SizedBox(
      height: 35.0,
      width: double.infinity,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: kMainEdgeMargin),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/forgotpassword');
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        ),
      ),
    );
  }

// Build "Create Account" button
  Row _buildCreateAccountButton() {
    return Row(
      children: [
        const SizedBox(width: kMainEdgeMargin),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/registration');
            },
            child: const Text('Create an Account'),
            style: ElevatedButton.styleFrom(
              onPrimary: kRHIGGreen,
              primary: kBackgroundColour,
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
        ),
        const SizedBox(width: kMainEdgeMargin),
      ],
    );
  }
}

class _LoginProperties {
  final _key = GlobalKey<FormState>();

  bool failed = false;

  bool _passwordObscured = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _LoginFieldLooks _usernameFieldLooks = _LoginFieldLooks();
  final _LoginFieldLooks _passwordFieldLooks = _LoginFieldLooks();

  final FocusNode _usernameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  late String loggedInAccount;

  bool loginSuccessful() {
    bool _success = false;
    //TODO: Add login check with server here, replacing dummy
    if (_usernameController.text == 'Correct' &&
        _passwordController.text == 'Correct') {
      loggedInAccount = _usernameController.text;
      failed = false;
      _success = true;
    } else {
      failed = true;
      _success = false;
    }
    return _success;
  }
}

//Used for changing input field colour and elevation properties upon focus changes
class _LoginFieldLooks {
  Color _colour = kBackgroundColour;
  double _elevation = 0;

  void isFocused() {
    _colour = Colors.white;
    _elevation = kElevation;
  }

  void isUnfocused() {
    _colour = kBackgroundColour;
    _elevation = 0;
  }
}
