import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/Api/controller.dart';
import 'package:provider_demo/Api/pagination/view.dart';
import 'package:provider_demo/firebase/controller.dart';
import 'package:provider_demo/firebase/data_add.dart';
import 'package:provider_demo/map/map_screen.dart';
import 'package:provider_demo/provider/countController.dart';
import 'package:provider_demo/provider/sliderController.dart';
import 'package:provider_demo/provider/theme_change_controller.dart';
import 'package:provider_demo/slder_screen.dart';
import 'package:provider_demo/theme_change_screen.dart';

import 'Api/pagination/controller.dart';
import 'Api/view.dart';
import 'favourite_screen.dart';
import 'homepage.dart';
import 'provider/favouriteController.dart';
import 'value_notify_listener.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterController()),
        ChangeNotifierProvider(create: (context) => SliderController()),
        ChangeNotifierProvider(create: (context) => FavouriteController()),
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider(create: (context) => ImageApiController()),
        ChangeNotifierProvider(create: (context) => PaginationController()),
        ChangeNotifierProvider(create: (context) => FireBaseController()),
      ],
      child: Builder(
        builder: (context) {
          final themeProvide = Provider.of<ThemeController>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvide.themeMode,
            theme: ThemeData(
              primarySwatch: Colors.red,
              brightness: Brightness.light,
              appBarTheme: AppBarTheme(color: Colors.red),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.green,
              appBarTheme: AppBarTheme(color: Colors.green),
            ),
            home: DataAdd(),
          );
        },
      ),
    );
  }
}

///AIzaSyCWdN30sKpfmbP6WtPrOrae29RkL9bn7EM
