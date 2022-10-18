import 'package:chat_app/widget/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var isLoading = false;

  void saveUser(
      String email, String password, bool islogin, BuildContext ctx, File image,
      [String? name]) async {
    UserCredential? authResult;
    try {
      setState(() {
        isLoading = true;
      });

      if (islogin) {
        authResult = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        setState(() {
          isLoading = false;
        });
      } else {
        if (kDebugMode) {
          print('i am here at signing up form');
        }

        authResult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final storageRef = FirebaseStorage.instance.ref();
        Reference? imageRef =
            storageRef.child('images').child('${authResult.user!.uid}.jpg');
        await imageRef.putFile(image).catchError((error) {
          Fluttertoast.showToast(msg: error.toString());
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({'email': email, 'name': name}).then(
          (eror) {
            setState(() {
              isLoading = false;
            });
          },
        );
      }
    } on PlatformException catch (error) {
      String message = 'An error occured please check your credentials';
      if (error.message != null) {
        message = error.message!;
        // showFlushbar(
        //     context: ctx,
        //     flushbar: Flushbar(
        //       title: '$error',
        //       backgroundColor: Colors.deepOrange,
        //     ));
        Fluttertoast.showToast(msg: message, backgroundColor: Colors.purple);
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });

      if (kDebugMode) {
        print(error);
        // showFlushbar(
        //     context: ctx,
        //     flushbar: Flushbar(
        //       title: '$error',
        //       backgroundColor: Colors.deepOrange,
        //     ));
        Fluttertoast.showToast(
            msg: error.toString(), backgroundColor: Colors.purple);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      saveUser: saveUser,
      isloading: isLoading,
    );
  }
}
