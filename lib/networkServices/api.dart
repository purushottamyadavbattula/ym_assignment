import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  final String url = "https://app.yellowmessenger.com/api/sso/v2login";
  Future<Map<String, dynamic>> getUserProfile(
      {@required String email, @required String password}) async {
    try {
      var body = {
        "username": email,
        "password": password,
        "type": "account",
        "referrer": "mobileApp"
      };
      var headers = {"Content-Type": "application/json"};
      print(body);
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("status code : ${response.statusCode}");
        print("response : ${response.body}");
        return {
          "error":
              "We are facing technical errors please try again after sometime"
        };
      }
    } catch (exception) {
      print("exception found $exception");
      return {
        "error":
            "We are facing technical errors please try again after sometime"
      };
    }
  }
}
