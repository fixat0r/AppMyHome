import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class generalSingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final Timestamp timeMessage;
  final String name;
  final String generalId;
  // final String dateMessage;
  //final int count;

  generalSingleMessage(
      {required this.message,
      required this.isMe,
      required this.timeMessage,
      required this.name,
      required this.generalId,
      // required this.dateMessage,
      //required this.count
      });

  @override
  Widget build(BuildContext context) {
    // var dateFormat = new DateFormat('dd MMMM yyyy');
    // String dateNow = dateFormat.format(DateTime.now());
    // String sendDate = dateFormat.format(dateMessage.toDate());
    var format = new DateFormat('HH:mm');
    String time = format.format(timeMessage.toDate());

    // String sendDate = FirebaseFirestore.instance
    //     .collection('general')
    //     .doc(generalId)
    //     .collection("chats")
    //     .doc(DateTime.now().toString())
    //     .toString();

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            constraints: BoxConstraints(maxWidth: 250),
            decoration: BoxDecoration(
                color: isMe ? Colors.blue : Color.fromARGB(255, 174, 174, 174),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(minWidth: 50),
                      child: Text(
                        name,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  textAlign: TextAlign.right,
                  time,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            )),
      ],
    );
  }
}
