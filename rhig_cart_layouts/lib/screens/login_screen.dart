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
  //TODO: Add proper field value handling including disposal etc.

  final _loginFormKey = GlobalKey<FormState>();

  bool _passwordObscured = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _InputPageFieldProperties _usernameFieldProperties =
      _InputPageFieldProperties();
  final _InputPageFieldProperties _passwordFieldProperties =
      _InputPageFieldProperties();

  final FocusNode _usernameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: Choose between option 1 - more expensive, but Column height is flex(option 2 lower)
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
                        Image.asset(
                          'assets/images/logo.png',
                          height: 120.0,
                        ),
                        const Text(
                          'APP FULL NAME',
                          style: kMainTitleTextStyle,
                        ),
                        const Text(
                          'Slogan Here',
                          style: kSloganTextStyle,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        //Notes for Login Screen Form: Wrapped the TextFormFields in Focus
                        //widgets to allow for the reliable background and elevation changes
                        //upon focus changes, this broke the auto keyboard display upon next
                        //field selection on keyboard. Used requestFocus to resolve this.
                        Form(
                          key: _loginFormKey,
                          child: Column(
                            children: [
                              _buildUsernameTextField(context),
                              const SizedBox(height: 15.0),
                              _buildPasswordTextField(context),
                            ],
                          ),
                        ),
                        _inputPageDivider,
                        //Forgot password TextButton
                        _buildForgotPasswordButton(),
                        const SizedBox(height: 10.0),
                        //Login ElevatedButton
                        BuildButton(
                            title: 'Login',
                            onPressed: () {
                              Navigator.pushNamed(context, '/search');
                            }),
                        Expanded(
                          child: Container(
                            height: 15.0,
                          ),
                        ),
                        _inputPageDivider,
                        const SizedBox(height: 20.0),
                        //"Create Account" ElevatedButton
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
      //TODO: Option 2 Less expensive, but not flexible column height
      // body: SafeArea(
      //   child: GestureDetector(
      //     onTap: () => FocusScope.of(context).unfocus(),
      //     child: Container(
      //       height: double.infinity,
      //       child: SingleChildScrollView(
      //         physics: const AlwaysScrollableScrollPhysics(),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             const SizedBox(height: 20.0),
      //             Image.asset(
      //               'assets/images/logo.png',
      //               height: 120.0,
      //             ),
      //             const Text(
      //               'APP FULL NAME',
      //               style: kMainTitleTextStyle,
      //             ),
      //             const Text(
      //               'Slogan Here',
      //               style: kSloganTextStyle,
      //             ),
      //             const SizedBox(
      //               height: 15.0,
      //             ),
      //             //Notes for Login Screen Form: Wrapped the TextFormFields in Focus
      //             //widgets to allow for the reliable background and elevation changes
      //             //upon focus changes, this broke the auto keyboard display upon next
      //             //field selection on keyboard. Used requestFocus to resolve this.
      //             Form(
      //               key: _loginFormKey,
      //               child: Column(
      //                 children: [
      //                   _buildUsernameTextField(context),
      //                   const SizedBox(height: 15.0),
      //                   _buildPasswordTextField(context),
      //                 ],
      //               ),
      //             ),
      //             _inputPageDivider,
      //             //Forgot password TextButton
      //             _buildForgotPasswordButton(),
      //             //Login ElevatedButton
      //             BuildButton(
      //                 title: 'Login',
      //                 onPressed: () {
      //                   Navigator.pushNamed(context, '/search');
      //                 }),
      //             const SizedBox(height: 80.0),
      //             _inputPageDivider,
      //             const SizedBox(height: 20.0),
      //             //"Create Account" ElevatedButton
      //             _buildCreateAccountButton(),
      //             const SizedBox(height: 15.0),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  //"Username" TextField builder
  Row _buildUsernameTextField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            color: _usernameFieldProperties.fieldColour,
            elevation: _usernameFieldProperties.fieldElevation,
            borderRadius: _kInputFieldBorderRadius,
            child: Focus(
              child: TextFormField(
                focusNode: _usernameNode,
                textInputAction: TextInputAction.next,
                controller: _usernameController,
                onFieldSubmitted: (value) {
                  _usernameController.text = value.toString();
                  //The following line activates the keyboard for the next field when pressing the
                  //next button in the current field, the default TextInputAction stopped working
                  //after adding the Focus widget
                  FocusScope.of(context).requestFocus(_passwordNode);
                },
                decoration: const InputDecoration(
                  fillColor: Colors.transparent,
                  filled: true,
                  contentPadding: _kFieldContentPadding,
                  border: InputBorder.none,
                  labelText: 'Username',
                  //TODO: Add username icon functionality (remove const)
                  labelStyle: kLoginFieldLabelTextStyle,
                  suffixIcon: Icon(
                    CupertinoIcons.check_mark,
                    size: 18.0,
                    color: kRHIGGreen,
                  ),
                ),
              ),
              onFocusChange: (hasFocus) {
                setState(() {
                  hasFocus
                      ? _usernameFieldProperties.activateField()
                      : _usernameFieldProperties.deactivateField();
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
            color: _passwordFieldProperties.fieldColour,
            elevation: _passwordFieldProperties.fieldElevation,
            borderRadius: _kInputFieldBorderRadius,
            child: Focus(
              child: TextFormField(
                focusNode: _passwordNode,
                textInputAction: TextInputAction.done,
                controller: _passwordController,
                obscureText: _passwordObscured,
                obscuringCharacter: '*',
                onFieldSubmitted: (value) {
                  setState(() {
                    _passwordController.text = value.toString();
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
                        _passwordObscured = !_passwordObscured;
                      });
                    },
                    icon: Icon(
                      _passwordObscured
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
                      ? _passwordFieldProperties.activateField()
                      : _passwordFieldProperties.deactivateField();
                });
              },
            ),
          ),
        ),
        const SizedBox(width: kMainEdgeMargin),
      ],
    );
  }

  //Divider builder
  final Divider _inputPageDivider = const Divider(
    indent: kMainEdgeMargin,
    endIndent: kMainEdgeMargin,
    thickness: 2.0,
    color: kDividerAndUnderlineColour,
  );

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

//Used for changing input field colour and elevation properties upon focus changes
class _InputPageFieldProperties {
  Color fieldColour = kBackgroundColour;
  double fieldElevation = 0;

  void activateField() {
    fieldColour = Colors.white;
    fieldElevation = kElevation;
  }

  void deactivateField() {
    fieldColour = kBackgroundColour;
    fieldElevation = 0;
  }
}

//Username and password field shape
const BorderRadiusGeometry _kInputFieldBorderRadius = BorderRadius.only(
  topRight: Radius.circular(kInputFieldRadius),
  bottomRight: Radius.circular(kInputFieldRadius),
);

const EdgeInsetsGeometry _kFieldContentPadding = EdgeInsets.symmetric(
  horizontal: kMainEdgeMargin,
  vertical: 10.0,
);
