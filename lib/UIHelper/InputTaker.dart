import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTaker extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  InputTaker(
      {this.controller,
      this.text,
      this.icon,
      this.keyboardType,
      this.obscureText});

  @override
  _InputTakerState createState() => _InputTakerState();
}

class _InputTakerState extends State<InputTaker> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(50),
      )),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: new InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.yellow,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.yellow,
              ),
            ),
            prefixIcon: Icon(
              widget.icon,
              color: Colors.blueGrey,
            ),
            labelText: widget.text,
            labelStyle: GoogleFonts.lobster(color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}
