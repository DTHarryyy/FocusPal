import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/features/chat_bot/services/cloud_firestore_service.dart';
import 'package:practice/features/chat_bot/services/gemini_service.dart';

class MessagesActions extends ConsumerStatefulWidget {
  final CollectionReference messages;
  final TextEditingController prompt;
  const MessagesActions(
      {super.key, required this.messages, required this.prompt});

  @override
  ConsumerState<MessagesActions> createState() => _MessagesActionsState();
}

class _MessagesActionsState extends ConsumerState<MessagesActions> {
  @override
  void dispose() {
    widget.prompt.dispose();
    super.dispose();
  }

  void sendQuestion(CloudFirestoreService firebase) async {
    try {
      final usermsg = widget.prompt.text.trim();
      if (usermsg.isEmpty) return;
      final gemini = GeminiService();

      await firebase.addMessage('Harry', usermsg, 'user');
      final response = await gemini.ask(usermsg);
      await firebase.addMessage('ChatBot', response, 'bot');
      widget.prompt.clear();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final firestore = ref.read(firestoreProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.attach_file)),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: widget.prompt,
                decoration: InputDecoration(
                  hint: Text('Type a message...'),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          //send btn
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => sendQuestion(firestore),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100),
              ),
              height: 45,
              width: 45,
              child: Center(child: Icon(Icons.send, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
