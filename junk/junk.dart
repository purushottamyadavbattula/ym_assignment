//import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:provider/provider.dart';
//import 'package:ym_inteview/UIHelper/botStrip.dart';
//import 'package:ym_inteview/model/Auth.dart';
//import 'package:ym_inteview/networkServices/api.dart';
//
//class ShowBots extends StatefulWidget {
//  @override
//  _ShowBotsState createState() => _ShowBotsState();
//}
//
//class _ShowBotsState extends State<ShowBots> {
//  List<Widget> prevBotCache = [];
//  List<Widget> botsToshow = [];
//  Api api = new Api();
//  TextEditingController searchController = new TextEditingController();
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: FutureBuilder(
//        future: api.getBots(token: Provider.of<Auth>(context).token),
//        builder: (context, snapshot) {
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return CircularProgressIndicator();
//          } else if (snapshot.hasError) {
//            print(snapshot.error);
//            return Text(
//                "Facing technical error please try again after sometime");
//          } else {
////            print(snapshot.data);
//
//            snapshot.data["data"]["botMappings"].forEach((bot) {
////              print(bot);
//              botsToshow.add(BotStrip(
//                botType: bot["botType"] ?? " ",
//                isFavourite: bot["isFavourite"] ?? false,
//                botIcon: bot["botIcon"] ?? null,
//                botName: bot["botName"] ?? " ",
//                botTitle: bot["botTitle"] ?? " ",
//              ));
//            });
//            prevBotCache = botsToshow;
//
//            return SingleChildScrollView(
//              child: Container(
//                  padding: EdgeInsets.all(10),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      SizedBox(
//                        height: MediaQuery.of(context).size.height / 5,
//                      ),
//                      Text(
//                        "Here are the bots",
//                        style: TextStyle(
//                          color: Colors.black,
//                          fontSize: 36,
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      Text(
//                        "You can also search to find your intrested bot",
//                        style: GoogleFonts.openSans(
//                          color: Colors.grey,
//                          fontSize: 18,
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      Row(
//                        children: [
//                          SizedBox(
//                            width: MediaQuery.of(context).size.width / 1.4,
//                          ),
//                          Text("Reset"),
//                          IconButton(
//                            icon: Icon(Icons.sync),
//                            onPressed: () {
//                              setState(() {
//                                botsToshow = prevBotCache;
//                              });
//                            },
//                          )
//                        ],
//                      ),
//                      searchBarForBots(searchController, setState,
//                          snapshot.data["data"]["botMappings"], context),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      Container(
//                        height: MediaQuery.of(context).size.height / 2,
//                        child: ListView(
//                          children: botsToshow,
//                        ),
//                      ),
//                    ],
//                  )),
//            );
//          }
//        },
//      ),
//    );
//  }
//
//  Widget searchBarForBots(TextEditingController controller, Function setState,
//      List<dynamic> bots, BuildContext context) {
//    Color colorBlue = Colors.black;
//    return TextField(
//      decoration: new InputDecoration(
//        focusedBorder: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(30),
//          borderSide: BorderSide(
//            color: colorBlue,
//          ),
//        ),
//        enabledBorder: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(30),
//          borderSide: BorderSide(
//            color: colorBlue,
//          ),
//        ),
//        prefixIcon: Icon(
//          Icons.search,
//          color: colorBlue,
//        ),
//        labelText: "Search bots by name",
//        labelStyle: GoogleFonts.lobster(color: Colors.grey),
//      ),
//      autocorrect: true,
//      onSubmitted: (value) {
//        print("submitted value $value");
//        List<dynamic> tempObj = [...bots];
//        List<Widget> op = [];
//        RegExp tempRegex;
////        print(tempObj);
//        tempObj.forEach((temp) {
//          value.split(" ").forEach((temp2) {
//            print('temp2 $temp2');
//            tempRegex = new RegExp(temp2);
//            if (tempRegex.hasMatch(temp["botName"])) {
//              print("match found ${temp["botName"]} ");
//              op.add(
//                BotStrip(
//                  botType: temp["botType"] ?? " ",
//                  isFavourite: temp["isFavourite"] ?? false,
//                  botIcon: temp["botIcon"] ?? null,
//                  botName: temp["botName"] ?? " ",
//                  botTitle: temp["botTitle"] ?? " ",
//                ),
//              );
////              tempObj.remove(temp);
//            }
//          });
//        });
//
//        print('found output is $op');
//
//        setState(() {
//          if (op.length > 0) {
//            botsToshow = op;
//          } else {
//            botsToshow = <Widget>[Text("Sorry no bot found")];
//          }
//        });
//      },
//    );
//  }
//}
