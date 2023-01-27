class LoginResponseModel {
  int? status;
  String? token;
  int? hotelierId;
  Hotel? hotel;

  LoginResponseModel({this.status, this.token, this.hotel});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    hotelierId = json['hotelierId'];
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.hotel != null) {
      data['hotel'] = this.hotel!.toJson();
    }
    return data;
  }
}

class Hotel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? contactNo;
  String? address;
  int? floors;
  int? rooms;
  String? startRoomNo;
  String? endRoomNo;
  String? wifiName;
  String? wifiPassword;
  String? policy;
  String? bancAccNo;
  String? bancAccHolderName;
  String? bancBranchName;
  String? iFSC;
  String? gST;
  String? pAN;
  String? createdAt;
  Null? deletedAt;

  Hotel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.contactNo,
      this.address,
      this.floors,
      this.rooms,
      this.startRoomNo,
      this.endRoomNo,
      this.wifiName,
      this.wifiPassword,
      this.policy,
      this.bancAccNo,
      this.bancAccHolderName,
      this.bancBranchName,
      this.iFSC,
      this.gST,
      this.pAN,
      this.createdAt,
      this.deletedAt});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    contactNo = json['contactNo'];
    address = json['address'];
    floors = json['floors'];
    rooms = json['rooms'];
    startRoomNo = json['startRoomNo'];
    endRoomNo = json['endRoomNo'];
    wifiName = json['wifiName'];
    wifiPassword = json['wifiPassword'];
    policy = json['policy'];
    bancAccNo = json['bancAccNo'];
    bancAccHolderName = json['bancAccHolderName'];
    bancBranchName = json['bancBranchName'];
    iFSC = json['IFSC'];
    gST = json['GST'];
    pAN = json['PAN'];
    createdAt = json['createdAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['contactNo'] = this.contactNo;
    data['address'] = this.address;
    data['floors'] = this.floors;
    data['rooms'] = this.rooms;
    data['startRoomNo'] = this.startRoomNo;
    data['endRoomNo'] = this.endRoomNo;
    data['wifiName'] = this.wifiName;
    data['wifiPassword'] = this.wifiPassword;
    data['policy'] = this.policy;
    data['bancAccNo'] = this.bancAccNo;
    data['bancAccHolderName'] = this.bancAccHolderName;
    data['bancBranchName'] = this.bancBranchName;
    data['IFSC'] = this.iFSC;
    data['GST'] = this.gST;
    data['PAN'] = this.pAN;
    data['createdAt'] = this.createdAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}
