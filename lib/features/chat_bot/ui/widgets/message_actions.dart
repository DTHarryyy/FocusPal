import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/features/Auth/provider/auth_changes_provider.dart';
import 'package:practice/features/chat_bot/model/message.dart';
import 'package:practice/features/chat_bot/provider/chats_provider.dart';
import 'package:practice/features/chat_bot/services/gemini_service.dart';

class MessagesActions extends ConsumerStatefulWidget {
  final Query msg;
  final TextEditingController prompt;
  const MessagesActions({super.key, required this.msg, required this.prompt});

  @override
  ConsumerState<MessagesActions> createState() => _MessagesActionsState();
}

class _MessagesActionsState extends ConsumerState<MessagesActions> {
  bool isLoading = false;
  @override
  void dispose() {
    widget.prompt.dispose();
    super.dispose();
  }
  void pickFile(){

  }
  void sendChat() async {
    final user = ref.watch(currentUserProvider).value;
    final saveMessage = ref.read(addNewChatProvider);

    try {
      setState(() => isLoading = true);

      final prompt = widget.prompt.text.trim();
      widget.prompt.clear();

      final userMsg = Message(userId: user!.uid, sender: 'user', message: prompt, createdAt: FieldValue.serverTimestamp());

      await saveMessage(userMsg);

      final res = await GeminiService().ask(prompt);
      final botMsg = Message(userId: user.uid, sender: 'bot', message: res, createdAt: FieldValue.serverTimestamp());
      await saveMessage(botMsg);

      setState(() => isLoading = false);

    } catch (e) {
      print('there must be an error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(onPressed: () => pickFile, icon: Icon(Icons.attach_file)),
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
          //send mun ah
          SizedBox(width: 5),
          AbsorbPointer(
            absorbing: isLoading,
            child: GestureDetector(
              onTap: sendChat,
              child: Container(
                decoration: BoxDecoration(
                  color: isLoading
                      ? const Color.fromARGB(255, 199, 198, 198)
                      : Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 45,
                width: 45,
                child: Center(child: Icon(Icons.send, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
