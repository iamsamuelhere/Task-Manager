import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DF extends StatefulWidget {
  @override
  _DFState createState() => _DFState();
}

class _DFState extends State<DF> {
  DateTime date;
  DateTime datepick;
  String updated;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Date formats"),
        centerTitle: true,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.calendar_today), onPressed:()async{
            datepick= await showDatePicker(context: context, initialDate:DateTime.now(), firstDate: DateTime(2020), lastDate:DateTime(2022));
           setState(() {
             date=datepick;
             updated=DateFormat.yMMMMd().format(date);
           });
            }),

          Text("$date"),
          Text("$updated")
        
                  ],
        ),
      )
      
    );
  }
}