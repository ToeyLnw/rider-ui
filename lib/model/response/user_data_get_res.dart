// To parse this JSON data, do
//
//     final userDataGetRes = userDataGetResFromJson(jsonString);

import 'dart:convert';

UserDataGetRes userDataGetResFromJson(String str) => UserDataGetRes.fromJson(json.decode(str));

String userDataGetResToJson(UserDataGetRes data) => json.encode(data.toJson());

class UserDataGetRes {
    int uid;
    String tel;
    String pass;
    String name;
    String address;
    String gps;
    String img;

    UserDataGetRes({
        required this.uid,
        required this.tel,
        required this.pass,
        required this.name,
        required this.address,
        required this.gps,
        required this.img,
    });

    factory UserDataGetRes.fromJson(Map<String, dynamic> json) => UserDataGetRes(
        uid: json["UID"],
        tel: json["tel"],
        pass: json["pass"],
        name: json["name"],
        address: json["address"],
        gps: json["GPS"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "UID": uid,
        "tel": tel,
        "pass": pass,
        "name": name,
        "address": address,
        "GPS": gps,
        "img": img,
    };
}
