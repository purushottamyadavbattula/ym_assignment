import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ym_inteview/UIHelper/InputTaker.dart';
import 'package:ym_inteview/model/Auth.dart';
import 'package:ym_inteview/networkServices/api.dart';
import 'package:ym_inteview/screens/showBots.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SharedPreferences _prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void login(String email, String password, BuildContext context,
      SharedPreferences prefs) async {
    final plainText = password;
    final key = encrypt.Key.fromBase64('wAT8E63Q/bKRkmpfkSH2Gg==');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encryptedPassword = encrypter.encrypt(plainText, iv: iv);
    Api api = new Api();
    Map<String, dynamic> data = await api.getUserProfile(
        email: email, password: encryptedPassword.base64);
    print("data found $data");
    if (data != null && data["error"] == null) {
      print("data found");
      prefs.setBool("login", true);
      prefs.setString(
        "user",
        jsonEncode(
          {
            "name": data["user"]["username"],
            "email": data["user"]["email"],
            "token": data["access_token"]
          },
        ),
      );
      Provider.of<Auth>(context, listen: false).setAuthDetails(
          email: data["user"]["email"], token: data["access_token"]);
    } else {
      //error hitting api
      return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          String errorMessage;
          if (data == null) {
            errorMessage = data["error"];
          } else {
            errorMessage = data["error"];
          }

          return AlertDialog(
            title: Text("Oops issues"),
            content: Text(errorMessage),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: Text("ok"),
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          );
        },
      );
    }
  }

  Widget loginScreen({BuildContext context, SharedPreferences preference}) {
    TextEditingController _emailController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: AssetImage('assets/ym.png'),
              width: 200,
              height: 200,
            ),
            Row(
              children: [
                Image(
                  image: AssetImage('assets/excitedBot.gif'),
                  height: 100,
                ),
                Column(
                  children: [
                    Text("Welcome,",
                        style: GoogleFonts.openSans(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis),
                    Text("Sign in to continue",
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            InputTaker(
              controller: _emailController,
              text: "Username",
              icon: Icons.perm_identity,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
            ),
            SizedBox(
              height: 20,
            ),
            InputTaker(
              controller: _passwordController,
              text: "Password",
              icon: Icons.keyboard,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  padding: EdgeInsets.all(15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  color: Colors.lightBlue,
                  child: Text(
                    "Login",
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    String email = _emailController.text,
                        password = _passwordController.text;
                    RegExp emailRegex = new RegExp(r"(.+)\@(\w+)\.[\w]{2,4}");
                    print("Email : $email \n Password : $password");
                    if (email != null &&
                        email.length > 0 &&
                        emailRegex.hasMatch(email) &&
                        password != null &&
                        password.length > 0) {
                      login(email, password, context, preference);
                      //hit api
                    } else {
                      String title = "Invalid",
                          message = "Please enter a valid";
                      if (email == null ||
                          email.length == 0 ||
                          !emailRegex.hasMatch(email)) {
                        title += " Email";
                        message += " email address";
                      }
                      if (password == null || password.length == 0) {
                        title += " Password";
                        message += " Password";
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      title,
//                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              content: Text(message),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              actions: [
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
//                                  linkControllers.clear();
                                    _emailController.clear();
                                    _passwordController.clear();
                                    Navigator.of(dialogContext)
                                        .pop(); // Dismiss alert dialog
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                _prefs = snapshot.data;
                bool login = _prefs.getBool("login") ?? false;
                print(login);
                if (login) {
                  String data = _prefs.getString("user") ?? null;
                  print(data);
                  if (data == null) {
                    return loginScreen(context: context, preference: _prefs);
                  } else {
                    Map<String, dynamic> temp = jsonDecode(data);
                    String email = temp["email"], token = temp["token"];
                    if (email != null && token != null) {
                      Provider.of<Auth>(context, listen: false)
                          .setAuthDetailsWithOutNotifier(
                              email: temp["email"], token: temp["token"]);
                      return ShowBots();
                    } else {
                      return loginScreen(context: context, preference: _prefs);
                    }
                  }
                } else {
                  return loginScreen(context: context, preference: _prefs);
//                  return Text("not logged in");
                }
              }
          }
        },
      ),
    );
  }
}
