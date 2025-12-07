import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/features/Auth/model/app_user.dart';

class AuthCredentialRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthCredentialRepository({required this.auth, required this.firestore});
  Future<AppUser> signIn(String email, String password) async {
    final userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    final uid = userCredential.user?.uid;

    final doc = await firestore.collection('UsersInformation').doc(uid).get();

    return AppUser.fromJson(doc.data()!);
  }

  Future<AppUser> signUp(String email, String password) async {
    final cred = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return AppUser(uid: cred.user!.uid, email: email, userName: '');
  }

  Future<void> saveUserData(AppUser user) async {
    await firestore
        .collection('UsersInformation')
        .doc(user.uid)
        .set(user.toJson());
  }
}
