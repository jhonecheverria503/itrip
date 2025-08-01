import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) =>
    json.encode(data.toJson());

class UserProfileResponse {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;

  UserProfileResponse({
    this.id,
    this.email,
    this.password,
    this.name,
    this.role,
    this.avatar,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "name": name,
    "role": role,
    "avatar": avatar,
  };
}
