import 'package:chat_app/widget/bubble_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy('timeStamp', descending: true)
                .snapshots(),

            //firebaseFirestore.instance.collection('chat').snapshots is returning querysnapshot

            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('No message is founded '));
              } else {
                var data = snapshot.data!.docs;
                return ListView.builder(
                    reverse: true,
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      if (kDebugMode) {
                        print(data[index]['userName']);
                      }
                      return BubleMessage(
                          message: data[index]['text'],
                          isMe: data[index]['userId'] == user!.uid,
                          name: data[index]['userName']);
                    }));
              }
            }));
  }
}
