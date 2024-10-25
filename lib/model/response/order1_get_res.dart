// To parse this JSON data, do
//
//     final order1GetRes = order1GetResFromJson(jsonString);

import 'dart:convert';

Order1GetRes order1GetResFromJson(String str) => Order1GetRes.fromJson(json.decode(str));

String order1GetResToJson(Order1GetRes data) => json.encode(data.toJson());

class Order1GetRes {
    int oid;
    int senderId;
    int recieverId;
    String name;
    String description;
    String origin;
    String destination;
    int status;
    String img;
    String senderName;
    String receiverName;
    String statusMessage;

    Order1GetRes({
        required this.oid,
        required this.senderId,
        required this.recieverId,
        required this.name,
        required this.description,
        required this.origin,
        required this.destination,
        required this.status,
        required this.img,
        required this.senderName,
        required this.receiverName,
        required this.statusMessage,
    });

    factory Order1GetRes.fromJson(Map<String, dynamic> json) => Order1GetRes(
        oid: json["OID"],
        senderId: json["senderID"],
        recieverId: json["recieverID"],
        name: json["name"],
        description: json["description"],
        origin: json["origin"],
        destination: json["destination"],
        status: json["status"],
        img: json["img"],
        senderName: json["sender_name"],
        receiverName: json["receiver_name"],
        statusMessage: json["status_message"],
    );

    Map<String, dynamic> toJson() => {
        "OID": oid,
        "senderID": senderId,
        "recieverID": recieverId,
        "name": name,
        "description": description,
        "origin": origin,
        "destination": destination,
        "status": status,
        "img": img,
        "sender_name": senderName,
        "receiver_name": receiverName,
        "status_message": statusMessage,
    };
}
