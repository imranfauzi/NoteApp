import 'package:cycle_app/controller/theme_controller.dart';
import 'package:cycle_app/view/Homepage.dart';
import 'package:cycle_app/view/Setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ThemeController());

    return SimpleBuilder(builder: (_) {
        return GetMaterialApp(
          theme: controller.theme,
          title: "SimplyList",
          initialRoute: '/',
          routes: <String, WidgetBuilder> {
            "/": (BuildContext context) => new Homepage(),
            "/setting": (BuildContext context) => new SettingsPage(),
          },


        );
      }
    );
  }
}


