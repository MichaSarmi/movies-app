

import 'package:flutter/material.dart';
import 'package:movies/screens/screens.dart';
class AppRoutes{
  static const initialRoute = '/home';
  static Map<String, Widget Function(BuildContext)> getAppRoutes()
  {
    Map<String, Widget Function(BuildContext)> appRoutes = {
        '/home'     :(BuildContext contenxt) => const HomeScreen(), 
        '/details':(BuildContext contenxt) => const DetailsScreen(),
  };
    return appRoutes;
  }
  static Route<dynamic> onGeneralRoute(RouteSettings settings){
        return  MaterialPageRoute(builder: (context) => const HomeScreen());
      }
}