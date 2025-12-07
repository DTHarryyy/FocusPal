import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/core/providers/firestore_provider.dart';

final userMessageProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore.collection('UserMessages');
});
