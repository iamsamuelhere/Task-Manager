import 'package:flutter/material.dart';
import 'package:mynotes/add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mynotes/buttonRef.dart';
import 'textref.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('tasks');

  TextEditingController taskup = TextEditingController();
  TextEditingController descup = TextEditingController();
  TimeOfDay timestch;
  TimeOfDay timest;

  DateTime datech;
  String datef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyNotes"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, snapshot) {
          return ListView.separated(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot doc = snapshot.data.documents[index];
              return Container(
          
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${doc['Task name']}",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("${doc['Description']}",style: TextStyle(fontWeight: FontWeight.w300)),
                            Text("${doc['Date']}",style: TextStyle(fontWeight: FontWeight.w300)),
                            Text("${doc['Time']}",style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: IconButton(
                                  icon: Icon(Icons.edit),
                                  color:Colors.red,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                                            title:Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                              Text("Update task"),
                                              IconButton(icon:Icon(Icons.close),onPressed: (){
                                                Navigator.pop(context);
                                              },)
                                            ],),
                                            content: SingleChildScrollView(
                                                                                          child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Textinput(
                                                    taskname: taskup,
                                                    hint: "enter update task",
                                                    label: "Update task",
                                                    icon: Icons.edit,
                                                  ),
                                                  SizedBox(height:20.0),
                                                  Textinput(
                                                    taskname: descup,
                                                    hint: "enter update desc",
                                                    label: "Update Description",
                                                    icon: Icons.more,
                                                  ),
                                                  DatetimeBut(
                                                    bg: Colors.red,
                                                    text: "Select time",
                                                    func: () async {
                                                      datech =
                                                          await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  DateTime.now(),
                                                              firstDate:
                                                                  DateTime(2020),
                                                              lastDate:
                                                                  DateTime(2050));
                                                      setState(() {
                                                        datef =
                                                            DateFormat.yMMMEd()
                                                                .format(datech);
                                                      });
                                                    },
                                                  ),
                                                  DatetimeBut(
                                                      bg: Colors.blue,
                                                      text: "Select time",
                                                      func: () async {
                                                        timestch =
                                                            await showTimePicker(
                                                                context: context,
                                                                initialTime:
                                                                    TimeOfDay
                                                                        .now());
                                                        setState(() {
                                                          timest = timestch;
                                                        });
                                                      }),
                                                  RaisedButton(
                                                      onPressed: () {
                                                        doc.reference.update({
                                                          "Task name":
                                                              taskup.text,
                                                          "Description":
                                                              descup.text,
                                                          "Date": datef,
                                                          "Time":timest.toString()
                                                        });
                                                      },
                                                      child: Text("Update task"))
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  })),
                          Expanded(
                              child: IconButton(
                                  splashColor: Colors.white,
                                  icon: Icon(Icons.delete,
                                  color: Colors.red,
                                  ),
                                  onPressed: () {
                                    doc.reference.delete();
                                  }))
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 1.0,
                height: 1.0,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Add(),
            ),
          );
        },
        label: Text("Add more"),
        icon: Icon(Icons.note_add),
      ),
    );
  }
}
