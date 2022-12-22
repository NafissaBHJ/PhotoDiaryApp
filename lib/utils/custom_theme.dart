import 'package:flutter/material.dart';

Color colorSecondary = const Color(0xffd4bebe);
Color colorSecondaryHint = Color.fromRGBO(212, 190, 190, 0.5);
// Color colorPrimary = Color(0xFF27203A);
Color colorPrimary = Color(0xFF2A2F34);
// Color colorPrimaryDarkShade = const Color(0xff3B3355);
Color colorPrimaryDarkShade = const Color(0xff495057);

ThemeData darktheme(BuildContext context) {
  TextTheme textTheme(TextTheme basetheme) {
    return basetheme.copyWith(
        headline1: basetheme.headline1!.copyWith(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
          color: colorSecondary,
        ),
        headline2: basetheme.headline2!.copyWith(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
          fontSize: 16.0,
          color: colorSecondary,
        ),
        headline3: basetheme.headline3!.copyWith(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 18.0,
          color: colorSecondary,
        ),
        bodyText1: basetheme.bodyText1!.copyWith(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
          fontSize: 16.0,
          color: colorSecondaryHint,
        ),
        bodyText2: basetheme.bodyText2!.copyWith(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
          fontSize: 14.0,
          color: colorSecondary,
        ),
        button: basetheme.button!.copyWith(
          color: colorSecondary,
        ));
  }

  AppBarTheme appBarTheme(AppBarTheme basetheme) {
    return basetheme.copyWith(elevation: 0, backgroundColor: colorPrimary);
  }

  final darktheme = ThemeData.dark();
  return darktheme.copyWith(
      primaryColor: colorPrimary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: colorSecondary,
      ),
      splashColor: colorPrimaryDarkShade,
      hintColor: colorSecondaryHint,
      scaffoldBackgroundColor: colorPrimary,
      textTheme: textTheme(darktheme.textTheme),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: colorPrimaryDarkShade,
          filled: true,
          hintStyle: TextStyle(color: colorSecondaryHint, fontSize: 18),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            width: 0,
            color: colorPrimaryDarkShade,
          )),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: colorPrimaryDarkShade,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0,
              ),
              borderRadius: BorderRadius.circular(5))),
      iconTheme: IconThemeData(color: colorSecondary, size: 20.0),
      appBarTheme: appBarTheme(darktheme.appBarTheme),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: colorSecondary)));
}
