import 'package:crud_app_api/product_list_screen.dart';
import 'package:flutter/material.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _lightThemeData(),
      darkTheme: _darkThemeData(),
      home: ProductListScreen(),
    );
  }

  ThemeData _lightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            backgroundColor: Colors.purple.shade500,
            foregroundColor: Colors.white,
          ),
        )
    );
  }

  ThemeData _darkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            backgroundColor: Colors.purple.shade500,
            foregroundColor: Colors.white,
          ),
        )
    );
  }
}