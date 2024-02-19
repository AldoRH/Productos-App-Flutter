

import 'package:flutter/material.dart';

class AppTheme {

  static const Color primary = Colors.indigo;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
        //Color primario
        primaryColor: Colors.indigo,


        //Scaffold
        scaffoldBackgroundColor: Colors.grey[300],

        //AppBar theme
        appBarTheme: const AppBarTheme(
          color: primary,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white,size: 26),
          titleTextStyle: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23, )
        ),
        
        //FloatingButtons
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: CircleBorder(),
          
        ),
      );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
        //Color primario
        primaryColor: Colors.indigo,
        //AppBar theme
        appBarTheme: const AppBarTheme( 
          color: primary,
          elevation: 0
        ),

        scaffoldBackgroundColor: Colors.black

);

}