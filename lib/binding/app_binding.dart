import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:whetherapp/controller/home_screen_controller.dart';
import 'package:whetherapp/controller/login_screen_controller.dart';
import 'package:whetherapp/controller/splash_screen_controller.dart';

import '../controller/firspage_controller.dart';
class AppBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => FirstpageController());
    Get.lazyPut(() => SplashScreenController());


  }
}