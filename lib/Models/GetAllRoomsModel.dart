class AllRoomsModel {
  int? status;
  int? results;
  List<Rooms>? data;

  AllRoomsModel({this.status, this.results, this.data});

  AllRoomsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <Rooms>[];
      json['data'].forEach((v) {
        data!.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  int? id;
  String? roomNo;
  bool? isAvailable;
  int? floor;
  String? createdAt;
  int? hotelId;
  int? restaurantOrder;
  int? houseKeepingOrders;
  int? laundryOrders;
  int? extraSupplies;
  int? feedback;

  Rooms(
      {this.id,
      this.roomNo,
      this.isAvailable,
      this.floor,
      this.createdAt,
      this.hotelId,
      this.restaurantOrder,
      this.houseKeepingOrders,
      this.laundryOrders,
      this.extraSupplies,
      this.feedback});

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomNo = json['roomNo'];
    isAvailable = json['isAvailable'];
    floor = json['floor'];
    createdAt = json['createdAt'];
    hotelId = json['hotelId'];
    restaurantOrder = json['restaurantOrder'];
    houseKeepingOrders = json['houseKeepingOrders'];
    laundryOrders = json['laundryOrders'];
    extraSupplies = json['extra-supplies'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomNo'] = this.roomNo;
    data['isAvailable'] = this.isAvailable;
    data['floor'] = this.floor;
    data['createdAt'] = this.createdAt;
    data['hotelId'] = this.hotelId;
    data['restaurantOrder'] = this.restaurantOrder;
    data['houseKeepingOrders'] = this.houseKeepingOrders;
    data['laundryOrders'] = this.laundryOrders;
    data['extra-supplies'] = this.extraSupplies;
    data['feedback'] = this.feedback;
    return data;
  }
}


class Hotel {
  int? status;
  Hotelier? hotelier;
  HotelData? hotel;

  Hotel({this.status, this.hotelier, this.hotel});

  Hotel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    hotelier = json['hotelier'] != null
        ? new Hotelier.fromJson(json['hotelier'])
        : null;
    hotel = json['hotel'] != null ? new HotelData.fromJson(json['hotel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.hotelier != null) {
      data['hotelier'] = this.hotelier!.toJson();
    }
    if (this.hotel != null) {
      data['hotel'] = this.hotel!.toJson();
    }
    return data;
  }
}

class Hotelier {
  int? id;
  int? hotelId;
  String? email;
  String? role;
  int? iat;

  Hotelier({this.id, this.hotelId, this.email, this.role, this.iat});

  Hotelier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hotelId = json['hotelId'];
    email = json['email'];
    role = json['role'];
    iat = json['iat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hotelId'] = this.hotelId;
    data['email'] = this.email;
    data['role'] = this.role;
    data['iat'] = this.iat;
    return data;
  }
}

class HotelData {
  int? id;
  String? name;

  HotelData({this.id, this.name});

  HotelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
