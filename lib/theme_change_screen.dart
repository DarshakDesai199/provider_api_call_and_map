import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/provider/theme_change_controller.dart';
import 'package:provider_demo/utilis/color.dart';

class ThemeChangeScreen extends StatefulWidget {
  const ThemeChangeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeChangeScreen> createState() => _ThemeChangeScreenState();
}

class _ThemeChangeScreenState extends State<ThemeChangeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context, listen: false);
    print('build ');
    return Scaffold(
      appBar: AppBar(title: Text("Theme Change"), centerTitle: true),
      body: Column(children: [
        RadioListTile(
          title: Text("Light Theme"),
          value: ThemeMode.light,
          groupValue: themeProvider.themeMode,
          onChanged: (value) {
            themeProvider.setThemeMode(value!);
          },
        ),
        RadioListTile(
          title: Text("Dark Theme"),
          value: ThemeMode.dark,
          groupValue: themeProvider.themeMode,
          onChanged: (value) {
            themeProvider.setThemeMode(value!);
          },
        ),
        RadioListTile(
          title: Text("System Theme"),
          value: ThemeMode.system,
          groupValue: themeProvider.themeMode,
          onChanged: (value) {
            themeProvider.setThemeMode(value!);
          },
        ),
      ]),
    );
  }
}
