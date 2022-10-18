import 'package:chat_app/widget/take_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AuthForm({Key? key, required this.saveUser, required this.isloading})
      : super(key: key);

  Function saveUser;
  bool isloading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _key = GlobalKey<FormState>();
  bool isLogin = true;
  String _email = '';
  String _password = '';
  String _name = '';
  File? _file;

  void saveImage(File pickedImage) {
    _file = pickedImage;
  }

  void logIn() {
    var isValid = _key.currentState!.validate();
    if (isValid) {
      _key.currentState!.save();
      if (kDebugMode) {
        widget.saveUser(_email.trim(), _password.trim(), isLogin, context,
            _file, _name.trim());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isLogin) TakeImage(saveImage: saveImage),
                  TextFormField(
                    validator: (email) {
                      if (!email!.contains('@')) {
                        return 'Email do not have @';
                      } else if (!email.contains('.')) {
                        return 'please put a dot .';
                      } else if (!email.endsWith('@gmail.com')) {
                        return 'email should contain @gmail.com';
                      } else if (email.isEmpty) {
                        return 'email should not be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                    decoration:
                        const InputDecoration(hintText: 'Enter your email'),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (password) {
                      if (password!.length < 6) {
                        return 'password should have at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                    decoration:
                        const InputDecoration(hintText: 'Enter your password'),
                  ),
                  if (!isLogin)
                    TextFormField(
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'name should not be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                      decoration:
                          const InputDecoration(hintText: 'Enter your name'),
                    ),
                  widget.isloading
                      ? const CircularProgressIndicator(
                          color: Colors.purple,
                        )
                      : ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.purple),
                          onPressed: () => logIn(),
                          child: isLogin
                              ? const Text('LogIn')
                              : const Text('SignUp')),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.purple),
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: isLogin
                        ? const Text('continue to SignUp')
                        : const Text('Continue to logIn'),
                  )
                ],
              )),
        )),
      ),
    );
  }
}
