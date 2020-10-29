import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ym_inteview/UIHelper/botStrip.dart';

class FetchBots extends StatefulWidget {
  List<Widget> botsCache;
  AsyncSnapshot<dynamic> snapshot;
  List<Widget> previousBotCache;
  FetchBots({List<Widget> botsCache, AsyncSnapshot snapshot}) {
    this.botsCache = botsCache;
    this.snapshot = snapshot;
    this.previousBotCache = botsCache;
  }
  @override
  _FetchBotsState createState() => _FetchBotsState();
}

class _FetchBotsState extends State<FetchBots> {
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Text(
                "Here are the bots",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "You can also search to find your intrested bot",
                style: GoogleFonts.openSans(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                  ),
                  Text("Reset"),
                  IconButton(
                    icon: Icon(Icons.sync),
                    onPressed: () {
                      setState(() {
                        widget.botsCache = widget.previousBotCache;
                      });
                    },
                  )
                ],
              ),
              searchBarForBots(searchController, setState,
                  widget.snapshot.data["data"]["botMappings"], context),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView(
                  children: widget.botsCache,
                ),
              ),
            ],
          )),
    ));
  }

  Widget searchBarForBots(TextEditingController controller, Function setState,
      List<dynamic> bots, BuildContext context) {
    Color colorBlue = Colors.black;
    return TextField(
      decoration: new InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: colorBlue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: colorBlue,
          ),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: colorBlue,
        ),
        labelText: "Search bots by name",
        labelStyle: GoogleFonts.lobster(color: Colors.grey),
      ),
      autocorrect: true,
      onSubmitted: (value) {
        print("submitted value $value");
        List<dynamic> tempObj = [...bots];
        List<Widget> op = [];
        print('op at the begining $op');
        List<String> duplicatesRemover = [];
        RegExp tempRegex;
//        print(tempObj);
        tempObj.forEach((temp) {
          value.split(" ").forEach((temp2) {
            print('temp2 $temp2');
            tempRegex = new RegExp(temp2, caseSensitive: false);
            if (tempRegex.hasMatch(temp["botName"])) {
              print("match found ${temp["botName"]} ");
              if (!duplicatesRemover.contains(temp["userName"])) {
                op.add(BotStrip(
                  botType: temp["botType"] ?? " ",
                  isFavourite: temp["isFavourite"] ?? false,
                  botIcon: temp["botIcon"] ?? null,
                  botName: temp["botName"] ?? " ",
                  botTitle: temp["botTitle"] ?? " ",
                ));
                duplicatesRemover.add(temp["userName"]);
              }

//              tempObj.remove(temp);
            }
          });
        });

        setState(() {
          if (op.length > 0) {
            widget.botsCache = op;
            controller.clear();
          } else {
            widget.botsCache = <Widget>[
              Text("Sorry no bot found"),
            ];
          }
        });
      },
    );
  }
}
