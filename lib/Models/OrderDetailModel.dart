import 'dart:ffi';

class OrderDetailModel {
  int? status;
  int? results;
  Data? data;

  OrderDetailModel({this.status, this.results, this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Feedbacks>? feedbacks;
  List<Orders>? orders;

  Data({this.feedbacks, this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['feedbacks'] != null) {
      feedbacks = <Feedbacks>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(new Feedbacks.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feedbacks {
  int? id;
  int? rating;
  String? feedback;
  String? createdAt;
  int? roomId;
  Room? room;
  bool? isRead = false;
  String type = "Feedback";

  Feedbacks(
      {this.id,
      this.rating,
      this.feedback,
      this.createdAt,
      this.isRead,
      this.roomId,
      this.room});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    feedback = json['feedback'];
    isRead = json['isRead'] ?? false;
    createdAt = json['createdAt'];
    roomId = json['roomId'];
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['feedback'] = this.feedback;
    data['createdAt'] = this.createdAt;
    data['roomId'] = this.roomId;
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    return data;
  }
}

class Room {
  int? id;
  String? roomNo;
  bool? isAvailable;
  int? floor;
  String? createdAt;
  int? hotelId;
  List<RoomToken>? roomToken;

  Room(
      {this.id,
      this.roomNo,
      this.isAvailable,
      this.floor,
      this.createdAt,
      this.hotelId,
      this.roomToken});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomNo = json['roomNo'];
    isAvailable = json['isAvailable'];
    floor = json['floor'];
    createdAt = json['createdAt'];
    hotelId = json['hotelId'];
    if (json['roomToken'] != null) {
      roomToken = <RoomToken>[];
      json['roomToken'].forEach((v) {
        roomToken!.add(new RoomToken.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomNo'] = this.roomNo;
    data['isAvailable'] = this.isAvailable;
    data['floor'] = this.floor;
    data['createdAt'] = this.createdAt;
    data['hotelId'] = this.hotelId;
    if (this.roomToken != null) {
      data['roomToken'] = this.roomToken!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomToken {
  int? id;
  String? authCode;
  bool? isActive;
  String? createdAt;
  int? roomId;

  RoomToken(
      {this.id, this.authCode, this.isActive, this.createdAt, this.roomId});

  RoomToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authCode = json['authCode'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    roomId = json['roomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['authCode'] = this.authCode;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['roomId'] = this.roomId;
    return data;
  }
}

class Orders {
  int? id;
  int? quantity;
  String? status;
  int? price;
  String? sGST;
  String? cGST;
  int? sGSTValue;
  int? cGSTValue;
  String? createdAt;
  int? roomId;
  int? restaurantItemId;
  int? houseKeepingItemId;
  Room? room;
  RestaurantItem? restaurantItem;
  RestaurantItem? houseKeepingItem;
  String? type;

  Orders(
      {this.id,
      this.quantity,
      this.status,
      this.price,
      this.sGST,
      this.cGST,
      this.sGSTValue,
      this.cGSTValue,
      this.createdAt,
      this.roomId,
      this.restaurantItemId,
      this.houseKeepingItemId,
      this.room,
      this.restaurantItem,
      this.houseKeepingItem,
      this.type});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    status = json['status'];
    price = json['price'];
    sGST = json['SGST'];
    cGST = json['CGST'];
    sGSTValue = json['SGSTValue'];
    cGSTValue = json['CGSTValue'];
    createdAt = json['createdAt'];
    roomId = json['roomId'];
    restaurantItemId = json['restaurantItemId'];
    houseKeepingItemId = json['houseKeepingItemId'];
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
    restaurantItem = json['restaurantItem'] != null
        ? new RestaurantItem.fromJson(json['restaurantItem'])
        : null;
    houseKeepingItem = json['houseKeepingItem'] != null
        ? new RestaurantItem.fromJson(json['houseKeepingItem'])
        : null;

    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['price'] = this.price;
    data['SGST'] = this.sGST;
    data['CGST'] = this.cGST;
    data['SGSTValue'] = this.sGSTValue;
    data['CGSTValue'] = this.cGSTValue;
    data['createdAt'] = this.createdAt;
    data['roomId'] = this.roomId;
    data['restaurantItemId'] = this.restaurantItemId;
    data['houseKeepingItemId'] = this.houseKeepingItemId;
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    if (this.restaurantItem != null) {
      data['restaurantItem'] = this.restaurantItem!.toJson();
    }
    data['houseKeepingItem'] = this.houseKeepingItem;
    data['type'] = this.type;
    return data;
  }
}

class RestaurantItem {
  int? id;
  String? name;
  String? image;
  int? price;
  int? time;
  int? stock;
  String? createdAt;
  int? categoryId;
  int? hotelId;

  RestaurantItem(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.time,
      this.stock,
      this.createdAt,
      this.categoryId,
      this.hotelId});

  RestaurantItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    time = json['time'];
    stock = json['stock'];
    createdAt = json['createdAt'];
    categoryId = json['categoryId'];
    hotelId = json['hotelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['time'] = this.time;
    data['stock'] = this.stock;
    data['createdAt'] = this.createdAt;
    data['categoryId'] = this.categoryId;
    data['hotelId'] = this.hotelId;
    return data;
  }
}
