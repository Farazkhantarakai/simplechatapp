import 'package:chat_app/widget/message.dart';
import 'package:chat_app/widget/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('LogOut')
                      ],
                    ))
              ];
            },
            child: const Icon(Icons.more_vert),
          )
        ],
        title: const Text('Chat Screen'),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            const Expanded(
              child: Message(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
