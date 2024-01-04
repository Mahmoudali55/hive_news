import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_news/view/styles/color_manger.dart';

abstract class ThemeManager {
  static ThemeData getTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorManger.black,
      appBarTheme: const AppBarTheme(
          color: ColorManger.black,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManger.black,
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: ColorManger.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
