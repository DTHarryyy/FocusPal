import 'package:cloud_firestore/cloud_firestore.dart';

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
    await userInformation.doc(userID).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'userID': userID,
    });
  }
}
