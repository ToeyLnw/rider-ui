// To parse this JSON data, do
//
//     final orderPostReq = orderPostReqFromJson(jsonString);

import 'dart:convert';

OrderPostReq orderPostReqFromJson(String str) => OrderPostReq.fromJson(json.decode(str));

String orderPostReqToJson(OrderPostReq data) => json.encode(data.toJson());

class OrderPostReq {
    int senderId;
    int recieverId;
    String name;
    String description;
    String origin;
    String destination;
    int status;
    String img;

    OrderPostReq({
        required this.senderId,
        required this.recieverId,
        required this.name,
        required this.description,
        required this.origin,
        required this.destination,
        required this.status,
        required this.img,
    });

    factory OrderPostReq.fromJson(Map<String, dynamic> json) => OrderPostReq(
        senderId: json["senderID"],
        recieverId: json["recieverID"],
        name: json["name"],
        description: json["description"],
        origin: json["origin"],
        destination: json["destination"],
        status: json["status"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "senderID": senderId,
        "recieverID": recieverId,
        "name": name,
        "description": description,
        "origin": origin,
        "destination": destination,
        "status": status,
        "img": img,
    };
}
