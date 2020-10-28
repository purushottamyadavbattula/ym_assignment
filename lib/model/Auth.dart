import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  String email;
  String token;
  bool login;

  void setAuthDetails({@required String email, @required String token}) {
    this.email = email;
    this.token = token;
    this.login = true;
    notifyListeners();
  }

  void setAuthDetailsWithOutNotifier(
      {@required String email, @required String token}) {
    this.email = email;
    this.token = token;
    this.login = true;
//    notifyListeners();
  }

  void setToken({String token}) {
    this.token = token;
    notifyListeners();
  }
}
