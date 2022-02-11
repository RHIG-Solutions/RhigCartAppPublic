import 'package:flutter/material.dart';
import 'package:rhig_cart_layouts/screens/registration_screen.dart';
import 'package:rhig_cart_layouts/screens/search_result_screen.dart';
import 'package:rhig_cart_layouts/screens/search_screen.dart';
import 'package:rhig_cart_layouts/styles.dart';
import 'package:rhig_cart_layouts/screens/forgot_password_screen.dart';
import 'package:rhig_cart_layouts/screens/splash_screen.dart';
import 'package:rhig_cart_layouts/screens/login_screen.dart';

void main() => runApp(const RHIGCartLayouts());

class RHIGCartLayouts extends StatelessWidget {
  const RHIGCartLayouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(accentColor: kRHIGGreen),
        scaffoldBackgroundColor: kBackgroundColour,
        shadowColor: kShadowColour,
        fontFamily: 'AvinerNext',
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
        // inputDecorationTheme: const InputDecorationTheme(
        //   labelStyle: kFieldLabelTextStyle,
        // ),
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgotpassword': (context) => const ForgotPasswordScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/search': (context) => const SearchPage(),
        '/searchresult': (context) => SearchResultPage(),
      },
      initialRoute: '/searchresult',
    );
  }
}
