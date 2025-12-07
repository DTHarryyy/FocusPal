import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/core/widgets/custom_loading.dart';

class Conversation extends StatelessWidget {
  final Query messages;
  const Conversation({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CustomLoading();
          var docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Text('No messages yet'),
            );
          }
          return ListView.separated(
              itemCount: docs.length,
              reverse: true,
              separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
              itemBuilder: (context, index) {
                var message = docs[index];
                bool isUser = message['sender'] == 'user';

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 350),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isUser
                            ? Colors.blue
                            : const Color.fromARGB(179, 242, 241, 241)),
                    child: Text(
                      message['message'],
                      style: GoogleFonts.outfit(
                          color: isUser
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : Colors.black),
                    ),
                  ),
                );
              });
        });
  }
}
