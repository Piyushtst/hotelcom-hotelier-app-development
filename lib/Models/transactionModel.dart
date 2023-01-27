import 'OrderDetailModel.dart';

class TransactionModel {
  int? status;
  int? results;
  List<Transaction>? data;

  TransactionModel({this.status, this.results, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <Transaction>[];
      json['data'].forEach((v) {
        data!.add(new Transaction.fromJson(v));
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

class Transaction {
  int? id;
  int? amount;
  String? status;
  String? authCode;
  String? createdAt;
  int? orderId;
  Orders? order;

  Transaction(
      {this.id,
      this.amount,
      this.status,
      this.authCode,
      this.createdAt,
      this.orderId,
      this.order});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    status = json['status'];
    authCode = json['authCode'];
    createdAt = json['createdAt'];
    orderId = json['orderId'];
    order = json['order'] != null ? new Orders.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['authCode'] = this.authCode;
    data['createdAt'] = this.createdAt;
    data['orderId'] = this.orderId;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}
