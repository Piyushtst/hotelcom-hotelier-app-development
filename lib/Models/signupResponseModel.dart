// To parse this JSON data, do
//
//     final signupResponseModel = signupResponseModelFromJson(jsonString);

import 'dart:convert';

SignupResponseModel signupResponseModelFromJson(String str) => SignupResponseModel.fromJson(json.decode(str));

String signupResponseModelToJson(SignupResponseModel data) => json.encode(data.toJson());

class SignupResponseModel {
  SignupResponseModel({
    this.status,
    this.data,
  });

  int? status;
  Data? data;

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) => SignupResponseModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.name,
    this.email,
    this.password,
    this.contactNo,
    this.department,
    this.hotelId,
    this.id,
    this.status,
    this.createdAt,
  });

  String? name;
  String? email;
  String? password;
  double? contactNo;
  String? department;
  int? hotelId;
  int? id;
  String? status;
  DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    contactNo: json["contactNo"] == null ? null : json["contactNo"].toDouble(),
    department: json["department"] == null ? null : json["department"],
    hotelId: json["hotelId"] == null ? null : json["hotelId"],
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "contactNo": contactNo == null ? null : contactNo,
    "department": department == null ? null : department,
    "hotelId": hotelId == null ? null : hotelId,
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}
