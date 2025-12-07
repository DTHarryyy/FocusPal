class AppUser {
  final String uid;
  final String email;
  final String userName;

  AppUser({
    required this.uid,
    required this.email,
    required this.userName,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      userName: json['userName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
    };
  }
}
