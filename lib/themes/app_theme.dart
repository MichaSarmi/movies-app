import 'package:flutter/material.dart';

/* archivo color de botones iconos ext */
class AppTheme{

  static const Color primary =  Colors.indigo;
  static const Color primaryDark =  Color.fromARGB(255, 18, 24, 53);

  static final ThemeData ligthTheme = ThemeData.light().copyWith(
        //color primario
        primaryColor: primary,
        //App bartheme
        appBarTheme: const AppBarTheme(
          color: primary,
          elevation: 0
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: primary, 
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
            ),
          ),
          
        ),
        //redondear todos los widgets tipo card
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          //sombra ocn opacidad
          shadowColor: primary.withOpacity(0.5),
          elevation: 8
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          elevation: 8
        ),

        //Elevated Butons'
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
          shape: const StadiumBorder(),
          elevation: 0
          ),
        ),
        //Alert
        dialogTheme: DialogTheme(
           shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
            )
        ),
        //input decoration
        inputDecorationTheme: const InputDecorationTheme(
          //titulo
          floatingLabelStyle: TextStyle(color: primary),
          //borders 
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          //borde focus
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))
          )
        ),
         
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
        //color primario
        primaryColor: primaryDark,
        //App bartheme
        appBarTheme: const AppBarTheme(
          color: primaryDark,
          elevation: 0,
          
        ),
        scaffoldBackgroundColor: Colors.black
  );
}