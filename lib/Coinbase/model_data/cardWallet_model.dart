import 'package:flutter/material.dart';

class cardDataModel {
  String? title,  value,  name,  id,date,numberCard;
  Color? gradient1,gradient2;
  cardDataModel({this.id,this.name,this.title,this.value,this.date,this.gradient1,this.gradient2,this.numberCard});
}

List<cardDataModel> listCard = [
  cardDataModel(
    id: "1",
    title: "Microsoft",
    name: "Frillya Azahra",
    value: "3975",
    date: "07/21",
    numberCard:"acb@gmailcom",
    gradient1: Color(0xFF6496F4),
    gradient2: Color(0xFF736AE6)
  ),
  cardDataModel(
    id: "2",
    title: "Amazon",
    name: "Zahira Azira",
    value: "2214",
    date: "01/20",
    numberCard:"asfsa@yahoo.com",
    gradient1: Color(0xFF36D1DC),
    gradient2: Color(0xFF5B86E5)
  ),
  cardDataModel(
    id: "3",
    title: "Paypal",
    name: "Alex Sugoi",
    value: "6533",
    date: "02/19",
    numberCard:"sdfds@outlook.com",
    gradient1: Color(0xFF6190E8),
    gradient2: Color(0xFFA7BFE8)
  ),
  
];