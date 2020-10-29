import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ym_inteview/UIHelper/botStrip.dart';
import 'package:ym_inteview/model/Auth.dart';
import 'package:ym_inteview/networkServices/api.dart';
import 'package:ym_inteview/screens/fetchBots.dart';

class ShowBots extends StatefulWidget {
  @override
  _ShowBotsState createState() => _ShowBotsState();
}

class _ShowBotsState extends State<ShowBots> {
  List<Widget> prevBotCache = [];
  List<Widget> botsToshow = [];
  Api api = new Api();
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getBots(token: Provider.of<Auth>(context).token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Scaffold(
            body:
                Text("Facing technical error please try again after sometime"),
          );
        } else {
//            print(snapshot.data);

          snapshot.data["data"]["botMappings"].forEach((bot) {
//              print(bot);
            botsToshow.add(BotStrip(
              botType: bot["botType"] ?? " ",
              isFavourite: bot["isFavourite"] ?? false,
              botIcon: bot["botIcon"] ?? null,
              botName: bot["botName"] ?? " ",
              botTitle: bot["botTitle"] ?? " ",
            ));
          });
          return FetchBots(
            botsCache: botsToshow,
            snapshot: snapshot,
          );
        }
      },
    );
  }
}
