import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynotes/buttonRef.dart';
import 'package:mynotes/df.dart';
import 'package:intl/intl.dart';
import 'package:mynotes/textref.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  DateTime datech;
  String datef;
  TimeOfDay timestch, timest;
  TextEditingController taskname = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
    
            Textinput(taskname: taskname,hint: "Type Task name",label: "Task",
            icon:Icons.edit
            ),
            SizedBox(
              height: 20.0,
            ),
            Textinput(taskname: desc,hint:"Type description",label:"Description",
            icon:Icons.more
            ),
                        SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                DatetimeBut(
                  bg:Colors.red,
                  text: "Select Date",
                  func:() async {
                      datech = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2050));
                      setState(() {
                        datef = DateFormat.yMMMEd().format(datech);
                      });
                    },
                    
                ),

                SizedBox(width: 20.0),
                Text("${datef??"Invalid date"}")
              ],
            ),
            Row(
              children: [
                DatetimeBut(
                  bg:Colors.blue,
                    text: "Select time",
                    func: () async {
                      timestch = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      setState(() {
                        timest = timestch;
                      });
                    }),
                SizedBox(width: 20.0),
                Text("${timest??"Invalid time"}")
              ],
            ),
            SizedBox(height: 50.0),
            RaisedButton(
                splashColor: Colors.white,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Colors.red,
                onPressed: () {
                  CollectionReference ref =
                      FirebaseFirestore.instance.collection('tasks');
                  ref
                      .add({
                        "Task name": taskname.text,
                        "Description": desc.text,
                        "Date": datef,
                        "Time": timest.toString()
                      })
                      .then((value) =>
                      showDialog(context: context,builder:(context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          content:Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                          Icon(Icons.check,color:Colors.green),
                          Text("Successfully Added",style:TextStyle(color:Colors.green))
                        ],)
                        );
                      })
                      )
                      .catchError((e) => print(e));
                },
                child: Text("+ Add Task",
                    style: TextStyle(color: Colors.white, fontSize: 20.0)))
          ],
        ),
      ),
    );
  }
}





