import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? accessToken;
  String? refreshToken;

  LoginResponse({this.accessToken, this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}
