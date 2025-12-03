import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/core/service/firestore_service.dart';

final authFirestoreProvider = Provider((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  return AuthFirestoreService(firestore);
});

class AuthFirestoreService {
  final FirebaseFirestore firestore;
  AuthFirestoreService(this.firestore);

  CollectionReference get userInformation =>
      firestore.collection('UserInformation');

  Future<void> addUserInformation(
    String name,
    String userID,
    String email,
  ) async {
    await userInformation.add({
      'name': name,
      'userID': userID,
      'email': email,
      'createdAt': FieldValue.serverTimestamp()
    });
  }
}
