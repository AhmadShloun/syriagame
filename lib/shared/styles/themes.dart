import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  // scaffoldBackgroundColor:HexColor('ebeff2'),
  primarySwatch: buildMaterialColor(white),
  appBarTheme: const AppBarTheme(
    //اذا عمل ايرور بحذف المكتبة وبرجعا
    //color: Colors.white,
    // titleSpacing: 20.0,
    // backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
    // backgroundColor: defaultColor,
    // elevation: 0.0,
    // titleTextStyle: TextStyle(
    //   color: Colors.white,
    //   fontSize: 20.0,
    //   fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.red,
    ),
  // ),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   type: BottomNavigationBarType.fixed,
  //   selectedItemColor: defaultColor,
  //   unselectedItemColor: Colors.grey,
  //   elevation: 20.0,
  //   backgroundColor: Colors.white,
  // ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);
ThemeData darkTheme = ThemeData(
  primarySwatch: buildMaterialColor(grey),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(

    titleSpacing: 20.0,
    // backwardsCompatibility: false,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: white,
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: white,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    // backgroundColor: HexColor('333739'),
    backgroundColor: Colors.purple,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);

