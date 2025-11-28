import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final List messages;
  const Messages({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          if (messages[index]['role'] == 'bot') {
            return Container(
              color: Colors.white,
              child: Text(messages[index]['message']),
            );
          } else {
            return Container(
              color: Colors.blue,
              child: Text(messages[index]['message']),
            );
          }
        });
  }
}
