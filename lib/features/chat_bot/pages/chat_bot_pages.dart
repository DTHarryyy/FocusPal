import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/features/chat_bot/widgets/message_actions.dart';
import 'package:practice/features/chat_bot/widgets/messages.dart';

class ChatBotPages extends StatefulWidget {
  const ChatBotPages({super.key});

  @override
  State<ChatBotPages> createState() => _ChatBotPagesState();
}

class _ChatBotPagesState extends State<ChatBotPages> {
  TextEditingController prompt = TextEditingController();
  final List messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
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
      title: Text(
        'ChatBot',
        style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      actions: [Icon(Icons.menu_rounded, size: 28)],
      actionsPadding: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
