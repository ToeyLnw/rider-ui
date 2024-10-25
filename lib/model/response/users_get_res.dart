// To parse this JSON data, do
//
//     final usersGetRes = usersGetResFromJson(jsonString);

import 'dart:convert';

UsersGetRes usersGetResFromJson(String str) => UsersGetRes.fromJson(json.decode(str));

String usersGetResToJson(UsersGetRes data) => json.encode(data.toJson());

class UsersGetRes {
    List<Datum> data;

    UsersGetRes({
        required this.data,
    });

    factory UsersGetRes.fromJson(Map<String, dynamic> json) => UsersGetRes(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int rid;
    String tel;
    String pass;
    String name;
    String address;
    String licensePlate;
    String img;

    Datum({
        required this.rid,
        required this.tel,
        required this.pass,
        required this.name,
        required this.address,
        required this.licensePlate,
        required this.img,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
