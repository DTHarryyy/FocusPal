import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/features/Auth/model/app_user.dart';

final currentUserProvider = StreamProvider<AppUser?>((ref) =>
    FirebaseAuth.instance.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      final doc = await FirebaseFirestore.instance
          .collection('UsersInformation')
          .doc(firebaseUser.uid)
          .get();
      if (!doc.exists) return null;
      return AppUser.fromJson(doc.data()!);
    }));
