import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String userId;
  final String sender;
  final String message;
  final FieldValue createdAt;

  Message(
      {required this.userId,
      required this.sender,
      required this.message,
      required this.createdAt});

  // json to object
  factory Message.fromJson(Map<String, dynamic> data, String userId) {
    return Message(
        sender: data['sender'],
        userId: userId,
        message: data['message'],
        createdAt: data['createdAt']);
  }
  // object to json
  Map<String, dynamic> toJson() {
    return {
      'userID': userId,
      'sender': sender,
      'message': message,
      'createdAt': createdAt
    };
  }
}
