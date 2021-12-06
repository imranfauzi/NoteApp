import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {

  //dark mode and switch
  final userTheme = GetStorage();
  bool get isDark => userTheme.read("darkMode") ?? false;
  ThemeData get theme => isDark ? ThemeData(brightness: Brightness.dark ): ThemeData(brightness: Brightness.light);
  void changeTheme(bool value) => userTheme.write("darkMode", value);

  //rive animation
  final rive = GetStorage();
  String get river => rive.read("rive");
  void setRive(String str) => rive.write("rive", str);

}

//,fontFamily: "Muli"