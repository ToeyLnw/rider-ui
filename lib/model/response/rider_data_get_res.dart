// To parse this JSON data, do
//
//     final riderDataGetRes = riderDataGetResFromJson(jsonString);

import 'dart:convert';

RiderDataGetRes riderDataGetResFromJson(String str) => RiderDataGetRes.fromJson(json.decode(str));

String riderDataGetResToJson(RiderDataGetRes data) => json.encode(data.toJson());

class RiderDataGetRes {
    int rid;
    String tel;
    String pass;
    String name;
    String address;
    String licensePlate;
    String img;

    RiderDataGetRes({
        required this.rid,
        required this.tel,
        required this.pass,
        required this.name,
        required this.address,
        required this.licensePlate,
        required this.img,
    });

    factory RiderDataGetRes.fromJson(Map<String, dynamic> json) => RiderDataGetRes(
        rid: json["RID"],
        tel: json["tel"],
        pass: json["pass"],
        name: json["name"],
        address: json["address"],
        licensePlate: json["license_plate"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "RID": rid,
        "tel": tel,
        "pass": pass,
        "name": name,
        "address": address,
        "license_plate": licensePlate,
        "img": img,
    };
}
