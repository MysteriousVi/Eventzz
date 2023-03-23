import 'dart:convert';

class EAForYouModel {
  String? hashtag;
  String? name;
  double? rating;
  String? add;
  String? attending;
  String? time;
  String? image;
  String? price;
  double? distance;
  bool? fev;

  EAForYouModel({this.hashtag, this.name, this.rating, this.add, this.attending, this.time, this.image, this.distance, this.price, this.fev = false});
}

class EAMessageModel {
  int? senderId;
  int? receiverId;
  String? msg;
  String? time;
  String? name;

  EAMessageModel({this.senderId, this.receiverId, this.msg, this.time, this.name});

  Map toJson() => {
    'name': name,
    'message': msg,
    'time': time,
    'senderId': senderId,
    'receiverId': 2,
  };
}
