import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ym_inteview/model/Auth.dart';
import 'package:ym_inteview/screens/login.dart';
import 'package:ym_inteview/screens/showBots.dart';
import 'package:ym_inteview/screens/startNavigator.dart';

void main() {
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => StartNavigator(),
        "/login": (context) => Login(),
        "/showBots": (context) => ShowBots(),
      },
    );
  }
}
