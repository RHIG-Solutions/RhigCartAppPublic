import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/constants.dart';
import 'package:rhig_cart_layouts/styles.dart';
import 'package:rhig_cart_layouts/reusables.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //TODO: Add proper field value handling including disposal etc.
  //General notes: Page currently set up for two forms, one for personal
  //details, one for address. This can be changed. The page currently feels
  //highly constrained.
  final _personalDetailsFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();

  final _PersonalDetailsFields _details = _PersonalDetailsFields();
  final _AddressFields _address1 = _AddressFields();

  bool _passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.fromLTRB(kMainEdgeMargin, 20.0, 0, 10.0),
                    child: Text(
                      'Personal Details',
                      style: kGeneralBoldTextStyle,
                    ),
                  ),
                  Material(
                    elevation: kElevation,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMainEdgeMargin),
                      child: _buildPersonalDetailsForm(),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.fromLTRB(kMainEdgeMargin, 15.0, 0, 10.0),
                    child: Text(
                      'Delivery Address',
                      style: kGeneralBoldTextStyle,
                    ),
                  ),
                  Material(
                    elevation: kElevation,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMainEdgeMargin),
                      child: _buildAddressForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: bottomButtonPadding,
        child: BuildButton(title: 'Register', onPressed: () {}),
      ),
    );
  }

  Form _buildPersonalDetailsForm() {
    return Form(
      key: _personalDetailsFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _details.name,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  decoration: _inputDecoration(label: 'Name'),
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: TextFormField(
                  controller: _details.surname,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(label: 'Surname'),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _details.mobileNumber,
            textInputAction: TextInputAction.next,
            decoration: _inputDecoration(
              label: 'Mobile Number',
              hint: '+1 (234)-45678',
            ),
          ),
          TextFormField(
            controller: _details.email,
            textInputAction: TextInputAction.next,
            decoration: _inputDecoration(
              label: 'Email Address',
              hint: 'email@rhig.com',
            ),
          ),
          TextFormField(
            controller: _details.password,
            textInputAction: TextInputAction.done,
            decoration: _passwordInputDecoration(label: 'Password'),
            obscureText: _passwordObscured,
            obscuringCharacter: '*',
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }

  Form _buildAddressForm() {
    return Form(
      key: _addressFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: _address1.unit,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(label: 'Unit No.'),
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _address1.street,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(label: 'Street Number & Name'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: _address1.postalCode,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(label: 'Postal Code'),
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _address1.suburb,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDecoration(label: 'Suburb'),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _address1.city,
            textInputAction: TextInputAction.done,
            decoration: _inputDecoration(
              label: 'City',
            ),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({required String label, String hint = ''}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: kRegistrationFieldLabelTextStyle,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kDividerAndUnderlineColour),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kRHIGGreen),
      ),
    );
  }

  InputDecoration _passwordInputDecoration(
      {required String label, String hint = ''}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: kRegistrationFieldLabelTextStyle,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kDividerAndUnderlineColour),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: kRHIGGreen),
      ),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _passwordObscured = !_passwordObscured;
          });
        },
        icon: Icon(
          _passwordObscured ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _PersonalDetailsFields {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
}

class _AddressFields {
  TextEditingController unit = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController suburb = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController city = TextEditingController();
}
