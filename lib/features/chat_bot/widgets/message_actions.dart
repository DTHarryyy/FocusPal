import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/features/Auth/presentation/pages/sign_in_page.dart';
import 'package:practice/features/Auth/provider/user_information_provider.dart';
import 'package:practice/features/chat_bot/services/cloud_firestore_service.dart';
import 'package:practice/features/chat_bot/services/gemini_service.dart';

class MessagesActions extends ConsumerStatefulWidget {
  final Query messages;
  final TextEditingController prompt;
  const MessagesActions(
      {super.key, required this.messages, required this.prompt});

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

  void sendQuestion(CloudFirestoreService firebase, userId) async {
    try {
      setState(() {
        isLoading = !isLoading;
      });
      final usermsg = widget.prompt.text.trim();
      widget.prompt.clear();

      if (usermsg.isEmpty) return;
      final gemini = GeminiService();

      await firebase.addMessage(userId, 'Harry', usermsg, 'user');

      final response = await gemini.ask(usermsg);
      await firebase.addMessage('1', 'ChatBot', response, 'bot');
      setState(() {
        isLoading = !isLoading;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final firestore = ref.read(firestoreProvider);
    final userCred = ref.read(userCredentialProvider);
    final uid = userCred?.user?.uid;
    if (uid == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
      });
      return SizedBox();
    }

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
          //send mun ah
          SizedBox(width: 5),
          AbsorbPointer(
            absorbing: isLoading,
            child: GestureDetector(
              onTap: () => sendQuestion(firestore, uid),
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
