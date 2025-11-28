import 'package:flutter/material.dart';
import 'package:practice/features/chat_bot/services/gemini_service.dart';

class MessagesActions extends StatefulWidget {
  final List messages;
  final TextEditingController prompt;
  const MessagesActions(
      {super.key, required this.messages, required this.prompt});

  @override
  State<MessagesActions> createState() => _MessagesActionsState();
}

class _MessagesActionsState extends State<MessagesActions> {
  @override
  void dispose() {
    widget.prompt.dispose();
    super.dispose();
  }

  void sendQuestion() async {
    try {
      final usermsg = widget.prompt.text.trim();
      final gemini = GeminiService();
      setState(() {
        widget.messages.add({
          'message': usermsg,
          'role': 'user',
          'name': 'Harry',
        });
      });

      final response = await gemini.ask(usermsg);
      setState(() {
        widget.messages.add({
          'message': response,
          'role': 'bot',
          'name': 'Bot',
        });
      });
      widget.prompt.clear();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.attach_file)),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Expanded(
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
          ),
          //send btn
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => sendQuestion(),
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
