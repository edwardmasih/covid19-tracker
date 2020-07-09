import 'package:covid19_tracker/homepage.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/datasource.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (brightness) {
        return ThemeData(
          primaryColor: primaryBlack,
          fontFamily: 'Circular',
          brightness: brightness == Brightness.light
              ? Brightness.light
              : Brightness.dark,
          scaffoldBackgroundColor: brightness == Brightness.dark
              ? Colors.blueGrey[900]
              : Colors.white,
        );
      },
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          home: HomePage(),
          debugShowCheckedModeBanner: false,
          theme: theme,
        );
      },
    );
  }
}

//WITHOUT THEME
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: HomePage(),
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primaryColor: primaryBlack,
//           fontFamily: 'Circular',
//           brightness: Brightness.dark
//         ));
//   }
// }
