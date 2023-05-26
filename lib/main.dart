import 'package:flutter/material.dart';
import 'package:medo_e_delirio_app/color_palette.dart';
import 'package:medo_e_delirio_app/screens/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //To generate icon
  //https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html#foreground.type=clipart&foreground.clipart=outlined_flag&foreground.space.trim=1&foreground.space.pad=0.25&foreColor=rgb(98%2C%20148%2C%2096)&backColor=rgb(36%2C%2049%2C%2025)&crop=0&backgroundShape=circle&effects=none&name=notification_icon

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Montserrat',
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );

    return MaterialApp(
        title: 'Flutter Demo',
        theme: theme.copyWith(
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: ColorPalette.secondary),
          primaryColor: ColorPalette.primary,
          scaffoldBackgroundColor: ColorPalette.primary,
          colorScheme: theme.colorScheme.copyWith(
            secondary: ColorPalette.secondary,
          ),
        ),
        debugShowCheckedModeBanner: false,
        //home: Home(),
        home: LandingPage());
  }
}
