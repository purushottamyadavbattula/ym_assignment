import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotStrip extends StatelessWidget {
  final String botIcon;
  final String botName;
  final String botTitle;
  final String botType;
  final bool isFavourite;
  BotStrip(
      {this.botIcon,
      this.isFavourite,
      this.botName,
      this.botTitle,
      this.botType});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            CircleAvatar(
              backgroundImage: (botIcon != null && botIcon != " ")
                  ? NetworkImage(botIcon)
                  : AssetImage("assets/alterChat.jpg"),
              radius: MediaQuery.of(context).size.width / 13,
              backgroundColor: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    botName,
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width / 28,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(botTitle,
                      style: GoogleFonts.openSans(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width / 35,
                      ),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  botType,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 28,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: isFavourite ? Colors.red : Colors.grey,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
