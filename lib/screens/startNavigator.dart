import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ym_inteview/model/Auth.dart';
import 'package:ym_inteview/screens/showBots.dart';

import 'login.dart';

class StartNavigator extends StatefulWidget {
  @override
  _StartNavigatorState createState() => _StartNavigatorState();
}

class _StartNavigatorState extends State<StartNavigator> {
  @override
  Widget build(BuildContext context) {
    return (Provider.of<Auth>(context).login != null &&
                Provider.of<Auth>(context).login) ==
            true
        ? ShowBots()
        : Login();
  }
}
