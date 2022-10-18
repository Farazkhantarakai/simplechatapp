import 'package:flutter/material.dart';

class BubleMessage extends StatelessWidget {
  BubleMessage(
      {Key? key, required this.message, required this.isMe, required this.name})
      : super(key: key);
  String message = '';
  bool isMe;
  String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 10, bottom: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: isMe ? Colors.grey : Colors.purple,
                borderRadius: !isMe
                    ? const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      )
                    : const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
            child: Column(
              children: [
                Text(name),
                Text(message),
              ],
            ))
      ],
    );
  }
}
