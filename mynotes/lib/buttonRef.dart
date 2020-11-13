import 'package:flutter/material.dart';

class DatetimeBut extends StatelessWidget {
  final String text;
  final Function func;
  Color bg;
  DatetimeBut({this.text,this.func,this.bg});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
    splashColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    onPressed: func
    ,child:Text(text,style: TextStyle(color:Colors.white),),
    color: bg);
  }
}