// To parse this JSON data, do
//
//     final loginPortReq = loginPortReqFromJson(jsonString);

import 'dart:convert';

LoginPortReq loginPortReqFromJson(String str) => LoginPortReq.fromJson(json.decode(str));

String loginPortReqToJson(LoginPortReq data) => json.encode(data.toJson());

class LoginPortReq {
    String tel;
    String pass;

    LoginPortReq({
        required this.tel,
        required this.pass,
    });

    factory LoginPortReq.fromJson(Map<String, dynamic> json) => LoginPortReq(
        tel: json["tel"],
        pass: json["pass"],
    );

    Map<String, dynamic> toJson() => {
        "tel": tel,
        "pass": pass,
    };
}
