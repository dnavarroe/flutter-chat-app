import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.username,
        required this.email,
        required this.online,
        required this.uid,
    });

    final String username;
    final String email;
    final bool online;
    final String uid;

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "online": online,
        "uid": uid,
    };
}
