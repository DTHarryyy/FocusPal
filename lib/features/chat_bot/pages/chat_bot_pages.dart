import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/core/service/firestore_service.dart';
import 'package:practice/features/chat_bot/widgets/message_actions.dart';
import 'package:practice/features/chat_bot/widgets/messages.dart';

class ChatBotPages extends ConsumerStatefulWidget {
  const ChatBotPages({super.key});

  @override
  ConsumerState<ChatBotPages> createState() => _ChatBotPagesState();
}

class _ChatBotPagesState extends ConsumerState<ChatBotPages> {
  TextEditingController prompt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final messages = ref
        .read(firebaseFirestoreProvider)
        .collection('ChatBotMessages')
        .orderBy('createdAt', descending: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Messages(
                  messages: messages,
                ),
              ),
            ),
            MessagesActions(
              messages: messages,
              prompt: prompt,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      title: Text(
        'ChatBot',
        style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600, color: Colors.black),
      ),
      centerTitle: true,
      actions: [Icon(Icons.menu_rounded, size: 28, color: Colors.black)],
      actionsPadding: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
