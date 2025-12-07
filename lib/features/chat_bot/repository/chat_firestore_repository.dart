import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/features/chat_bot/model/message.dart';

class ChatFirestoreRepository {
  final FirebaseFirestore firestore;
  ChatFirestoreRepository(this.firestore);

  Future<void> addNewMessage(Message msg) async {
    await firestore
        .collection('UserChatBot')
        .doc(msg.userId)
        .collection('Messages')
        .add(msg.toJson());
  }
}
