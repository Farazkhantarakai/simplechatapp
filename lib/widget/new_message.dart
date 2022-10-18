import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var message = TextEditingController();
  String newMessage = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: message,
              onChanged: (text) {
                setState(() {
                  newMessage = text;
                });
              },
              decoration: const InputDecoration(hintText: 'Enter your message'),
            ),
          ),
          IconButton(
              onPressed: newMessage.trim().isEmpty
                  ? null
                  : () async {
                      var user = FirebaseAuth.instance.currentUser;
                      var userData = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid)
                          .get();
                      if (kDebugMode) {
                        print(userData['name']);
                      }
                      FirebaseFirestore.instance.collection('chat').add({
                        'text': newMessage,
                        'timeStamp': Timestamp.now(),
                        'userId': FirebaseAuth.instance.currentUser!.uid,
                        'userName': userData['name']
                      });
                      FocusScope.of(context).unfocus();
                      message.text = '';
                    },
              icon: newMessage.trim().isEmpty
                  ? const Icon(
                      Icons.send,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.send,
                      color: Colors.purple,
                    ))
        ],
      ),
    );
  }
}
