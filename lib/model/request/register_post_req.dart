// To parse this JSON data, do
//
//     final registerPostReq = registerPostReqFromJson(jsonString);

import 'dart:convert';

RegisterPostReq registerPostReqFromJson(String str) => RegisterPostReq.fromJson(json.decode(str));

String registerPostReqToJson(RegisterPostReq data) => json.encode(data.toJson());

class RegisterPostReq {
    String tel;
    String pass;
    String name;
    String address;
    String img;

    RegisterPostReq({
        required this.tel,
        required this.pass,
        required this.name,
        required this.address,
        required this.img,
    });

    factory RegisterPostReq.fromJson(Map<String, dynamic> json) => RegisterPostReq(
        tel: json["tel"],
        pass: json["pass"],
        name: json["name"],
        address: json["address"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "tel": tel,
        "pass": pass,
        "name": name,
        "address": address,
        "img": img,
    };
}
