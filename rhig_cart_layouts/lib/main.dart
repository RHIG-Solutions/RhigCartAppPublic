import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/screens/delivery_method_screen.dart';
import 'package:rhig_cart_layouts/screens/my_cart_screen.dart';
import 'package:rhig_cart_layouts/screens/order_summary_screen.dart';
import 'package:rhig_cart_layouts/screens/product_details_screen.dart';
import 'package:rhig_cart_layouts/screens/product_item_screen.dart';
import 'package:rhig_cart_layouts/screens/registration_screen.dart';
import 'package:rhig_cart_layouts/screens/search_result_screen.dart';
import 'package:rhig_cart_layouts/screens/search_screen.dart';
import 'package:rhig_cart_layouts/screens/vendor_store_screen.dart';
import 'package:rhig_cart_layouts/styles.dart';
import 'package:rhig_cart_layouts/screens/forgot_password_screen.dart';
import 'package:rhig_cart_layouts/screens/splash_screen.dart';
import 'package:rhig_cart_layouts/screens/login_screen.dart';

void main() => runApp(const RHIGCartLayouts());

class RHIGCartLayouts extends StatelessWidget {
  const RHIGCartLayouts({Key? key}) : super(key: key);

  //TODO: Replace missing image default with proper image.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(accentColor: kRHIGGreen),
        scaffoldBackgroundColor: kBackgroundColour,
        shadowColor: kShadowColour,
        fontFamily: 'AvinerNext',
        unselectedWidgetColor: kRHIGGrey,
        toggleableActiveColor: kRHIGGreen,
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: kRHIGGrey),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: kRHIGGreen,
          selectionHandleColor: kRHIGGreen,
          selectionColor: kSelection,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          color: kRHIGGreen,
          titleTextStyle: kAppBarTextStyle,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: kRHIGGrey),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: kRHIGGreen, onPrimary: kBackgroundColour),
        ),
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgotpassword': (context) => const ForgotPasswordScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/search': (context) => const SearchPage(),
        '/searchresult': (context) => SearchResultPage(),
        '/store': (context) => const VendorStoreScreen(),
        '/productitem': (context) => const ProductItemScreen(),
        '/productdetails': (context) => const ProductDetailsScreen(),
        '/mycart': (context) => const MyCartScreen(),
        '/deliverymethod': (context) => const DeliveryMethodScreen(),
        '/ordersummary': (context) => OrderSummaryScreen(),
      },
      initialRoute: '/login',
    );
  }
}
