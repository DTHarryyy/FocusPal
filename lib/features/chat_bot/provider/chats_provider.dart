import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/features/chat_bot/repository/chat_firestore_repository.dart';
import 'package:practice/features/chat_bot/use%20case/chats_usecase.dart';

final chatsRepositoryProvider =
    Provider((ref) => ChatFirestoreRepository(FirebaseFirestore.instance));

final addNewChatProvider =
    Provider((ref) => AddNewMEssageUseCase(ref.read(chatsRepositoryProvider)));
