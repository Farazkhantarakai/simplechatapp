import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'screens/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // var snapshot = firestore
    //     .collection('chat')
    //     .doc('JjsVqUIGm0pSSOLCZEHU')
    //     .collection('messages')
    //     .snapshots();
    //if you are geting data from collection it is returning QuerySnapshot
    //otherwise it will DocumentSnapshot
    return MaterialApp(
        home: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          if (kDebugMode) {
            print('i am inside this shit');
          }
          return const ChatScreen();
        } else {
          return AuthScreen();
        }
      }),
    )
        //it will store the first result then if we become offline
        //it will display the last result as displayed before because of cache
        // const source = Source.cache;
        // FirebaseFirestore.instance
        //     .collection('chat/JjsVqUIGm0pSSOLCZEHU/messages')
        //     .doc('LqNO3HdUy9fXY3ulHvsb')
        //     .get(const GetOptions(source: source))
        //     .then((value) {
        //   if (kDebugMode) {
        //     print(value.data()!['text']);
        //   }
        // });
        //how to add data to firebase firestore
        // FirebaseFirestore.instance.collection('users').doc('first').set(
        //     {'one': 'No', 'second': 'yes', 'third': 'oh yes or no'},
        //     //set option will update the data if already exists else will add
        //     SetOptions(merge: true));
        );
  }
}
