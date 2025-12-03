class AppUser {
  final String userName;
  final String email;
  final String uid;
  AppUser({required this.email, required this.userName, required this.uid});

  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
        email: data['userID'], userName: data['userName'], uid: data['email']);
  }

  Map<String, dynamic> toMap() {
    return {'userId': uid, 'name': userName, 'enail': email};
  }
}
