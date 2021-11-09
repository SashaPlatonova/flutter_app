import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomTheme with ChangeNotifier{

  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  Future<void> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getInt('theme') == 1){
      _isDarkTheme = false;
    }
    else {
      _isDarkTheme = true;
    }
  }

  static ThemeData get lightTheme {
    return ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromRGBO(226, 235, 255, 1.0),
          elevation: 0,
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)
        ),
        canvasColor: Color.fromRGBO(226, 235, 255, 1.0),
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Manrope',
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(226, 235, 255, 1.0),
            onPrimary: Colors.black,
            shape: CircleBorder(),
            elevation: 0)),
        // bottomSheetTheme: BottomSheetThemeData(
        //   backgroundColor: Color.fromRGBO(226, 235, 255, 1.0)),
      textTheme: TextTheme(headline4: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Color.fromRGBO(130, 130, 130, 1.0), fontWeight: FontWeight.w600, fontSize: 10),
          headline2: TextStyle(color: Colors.black),
        headline6: TextStyle(color: Color.fromRGBO(90, 90, 90, 1.0))
      ),
      primaryColor: Colors.black,
      primaryColorLight: Color.fromRGBO(255, 255, 255, 0.05),
      cardColor: Color.fromRGBO(255, 255, 255, 0.15),
      shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
      colorScheme: ColorScheme(
          primary: Color.fromRGBO(1, 97, 254, 1.0),
          primaryVariant: Color.fromRGBO(1, 97, 254, 1.0),
          secondary: Color.fromRGBO(226, 235, 255, 1.0),
          secondaryVariant: Color.fromRGBO(3, 140, 254, 1.0),
          surface: Color.fromRGBO(50, 50, 50, 1.0),
          background: Color.fromRGBO(226, 235, 255, 1.0),
          error: Color.fromRGBO(75, 95, 136, 1.0),
          onPrimary: Color.fromRGBO(224, 233, 253, 1.0),
          onSecondary:  Color.fromRGBO(90, 90, 90, 1.0),
          onSurface: Color.fromRGBO(222, 233, 255, 1.0),
          onBackground: Color.fromRGBO(74, 74, 74, 1),
          onError: Color.fromRGBO(58, 58, 58, 0.1),
          brightness: Brightness.light)
      // toggleButtonsTheme: ToggleButtonsThemeData(selectedColor: )
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      cardColor: Color.fromRGBO(255, 255, 255, 0.05),
      primaryColor: Colors.white,
      shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
      textTheme: TextTheme(headline3: TextStyle(color: Color.fromRGBO(170, 170, 170, 1.0), fontWeight: FontWeight.w600, fontSize: 10),
      headline4: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Color.fromRGBO(210, 210, 210, 1.0))),
      colorScheme: ColorScheme(
          primary: Color.fromRGBO(10, 23, 67, 1.0),
          primaryVariant: Color.fromRGBO(7, 20, 39, 0.9),
          secondary: Color.fromRGBO(12, 22, 43, 1.0),
          secondaryVariant: Colors.white,
          surface: Colors.white,
          background: Color.fromRGBO(238, 244, 255, 1.0),
          error: Color.fromRGBO(14, 24, 44, 1.0),
          onPrimary: Color.fromRGBO(13, 24, 44, 1.0),
          onSecondary: Color.fromRGBO(177, 177, 177, 1.0),
          onSurface: Color.fromRGBO(12, 22, 43, 1.0),
          onBackground: Colors.white,
          onError: Color.fromRGBO(188, 188, 188, 0.07),
          brightness: Brightness.dark
      )
    );
  }
}