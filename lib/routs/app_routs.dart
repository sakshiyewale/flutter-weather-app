
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:whetherapp/routs/routs.dart';
import 'package:whetherapp/screens/firstpage.dart';
import 'package:whetherapp/screens/home.dart';
import 'package:whetherapp/screens/splash_screen.dart';

import '../binding/app_binding.dart';
import '../screens/login.dart';


class AppPages
{
  static String INITIAL_ROUTE = AppRoutes.SPLASH_SCREEN_ROUTE;
  static final Pages =
  [

    GetPage(
        name: AppRoutes.SPLASH_SCREEN_ROUTE,
        page: ()=>SplashScreen(),
        binding:AppBinding()
    ),
    GetPage(
        name: AppRoutes.LOGIN_SCREEN_ROUTE,
        page: ()=>LoginScreen(),
        binding:AppBinding()
    ),
    GetPage(
        name: AppRoutes.HOME_SCREEN_ROUTE,
        page: ()=>WeatherHomePage(),
        binding:AppBinding()
    ),
    GetPage(
        name: AppRoutes.FIRST_PAGE_ROUTE,
        page: ()=>Firstpage(),
        binding:AppBinding()
    ),

  ];

}