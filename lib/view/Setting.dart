import 'package:cycle_app/Custom/cusText.dart';
import 'package:cycle_app/controller/theme_controller.dart';
import 'package:cycle_app/view/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';



class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Artboard _riveArtboard;
  RiveAnimationController _controller;
  final controller = Get.put(ThemeController());

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/anims/dark.riv').then(
          (data) async {
        final file = RiveFile.import(data);
        if (RiveFile.import(data) != null) {
          final artboard = file.mainArtboard;
          artboard.addController(_controller = SimpleAnimation(controller.river));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    Size sizes = MediaQuery.of(context).size;
    //final controller = Get.put(ThemeController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 7,),
            Row(
              children: [
                IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                  Get.to(() =>Homepage());
               //   Navigator.of(context).pushReplacementNamed('/');
                }),
                Text("Settings", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),

              ],
            ),
            SizedBox(height: 20,),
            Image(image: AssetImage('assets/images/settings.png'),height: sizes.height/6,),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.info),
              title: cusText("Version 1.0.0", 16),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: cusText("m.imran.fauzi@gmail.com", 16),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.insert_drive_file),
              title: cusText("About Developer", 16),
              subtitle: Text("Follow our Instagram 'blackcoffee' for more information"),
            ),
            Divider(),
            SizedBox(height: 10,),
            Center(child: Text("Dark Mode"),),
            Switch(value: controller.isDark, onChanged: (val){
              controller.changeTheme(val);
              if(controller.isDark){
                setState(() {

                });
                _riveArtboard.removeController(_controller);
                _riveArtboard.addController(_controller = SimpleAnimation('toDark'));
                controller.setRive("toDark");
              }else {
                setState(() {

                });
                _riveArtboard.removeController(_controller);
                _riveArtboard.addController(_controller = SimpleAnimation('toLight'));
                controller.setRive("toLight");
              }
            }),
            Flexible(
              child: Center(
                child: _riveArtboard == null
                    ? const SizedBox()
                    : Rive(artboard: _riveArtboard),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
// if(controller.isDark){
// Get.changeTheme(ThemeData.dark());
// _riveArtboard.removeController(_controller);
// _riveArtboard.addController(_controller = SimpleAnimation('toDark'));
// }else {
// Get.changeTheme(ThemeData.light());
// _riveArtboard.removeController(_controller);
// _riveArtboard.addController(_controller = SimpleAnimation('toLight'));
// }