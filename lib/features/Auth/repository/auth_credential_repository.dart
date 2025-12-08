import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/features/Auth/model/app_user.dart';

class AuthCredentialRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthCredentialRepository({required this.auth, required this.firestore});
  Future<User> signIn(String email, String password) async {
    final cred =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return cred.user!;
  }

  Future<User> signUp(String email, String password) async {
    final cred = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return cred.user!;
  }
  Future<AppUser> getUser(String uid) async {
    final snapShot = await firestore.collection('UsersInformation').doc(uid).get();
    return AppUser.fromJson(snapShot.data()!);
  }
  Future<void> saveUserData(AppUser user) async {
    await firestore
        .collection('UsersInformation')
        .doc(user.uid)
        .set(user.toJson());
  }
}
