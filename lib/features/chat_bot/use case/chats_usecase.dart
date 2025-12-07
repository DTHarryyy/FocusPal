import 'package:practice/features/chat_bot/model/message.dart';
import 'package:practice/features/chat_bot/repository/chat_firestore_repository.dart';

class AddNewMEssageUseCase {
  final ChatFirestoreRepository repository;
  AddNewMEssageUseCase(this.repository);

  Future<void> call(Message msg) => repository.addNewMessage(msg);
}
