import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/core/service/firestore_service.dart';

final firestoreProvider = Provider<CloudFirestoreService>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  return CloudFirestoreService(firestore);
});

class CloudFirestoreService {
  final FirebaseFirestore firestore;
  CloudFirestoreService(this.firestore);

  CollectionReference get messages => firestore.collection('ChatBotMessages');

  Future<void> addMessage(String name, String message, String sender) async {
    await messages.add({'name': name, 'message': message, 'sender': sender});
  }

  Future<void> updateMessage(String docId, String newMessage) async {
    await messages.doc(docId).update({'message': newMessage});
  }

  Future<void> deleteItem(String docId) async {
    await messages.doc(docId).delete();
  }
}
