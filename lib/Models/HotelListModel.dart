// To parse this JSON data, do
//
//     final hotelListModel = hotelListModelFromJson(jsonString);

import 'dart:convert';

HotelListModel hotelListModelFromJson(String str) =>
    HotelListModel.fromJson(json.decode(str));

String hotelListModelToJson(HotelListModel data) => json.encode(data.toJson());

class HotelListModel {
  int? status;
  int? results;
  List<HotelList>? data;

  HotelListModel({this.status, this.results, this.data});

  HotelListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <HotelList>[];
      json['data'].forEach((v) {
        data!.add(HotelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "results": results,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HotelList {
  int? id;
  String? name;

  HotelList({
    this.id,
    this.name,
  });

  factory HotelList.fromJson(Map<String, dynamic> json) =>
      HotelList(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
