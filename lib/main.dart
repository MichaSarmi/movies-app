import 'package:flutter/material.dart';

import 'package:movies/router/app_routes.dart';
import 'package:movies/themes/app_theme.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';


void main() => runApp( const AppState());
class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  //multiprovider para varias peticiones
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //cambiar el lazy para q se inbicialice
        ChangeNotifierProvider(create: (_)  => MoviesProvider() ),
      ],
      child: const MyApp(),
      );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: AppRoutes.initialRoute,
      routes:  AppRoutes.getAppRoutes(),
     // onGenerateRoute: AppRoutes.onGeneralRoute,
      theme: AppTheme.ligthTheme,
      
    );
  }
}