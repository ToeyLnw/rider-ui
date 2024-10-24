import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:call_your_rider/config/config.dart';
import 'package:call_your_rider/model/request/login_port_req.dart';
import 'package:call_your_rider/page/RiderHome.dart';
import 'package:call_your_rider/page/register.dart';
import 'package:call_your_rider/page/riderUpdate.dart';
import 'package:call_your_rider/page/userSender.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String text = "";
  String url = "";
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController passCtl = TextEditingController();
  Color getRandomColor() {
    // สุ่มสีจาก Color
    math.Random random = math.Random();
    return Color.fromARGB(
      255, // Alpha
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(205, 192, 253, 70),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/image/SE_logo.png'),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0)),
                      color: const Color.fromARGB(255, 253, 242, 242),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 30.0),
                              child: Text(
                                "เข้าสู่ระบบ",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30.0, bottom: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("เบอร์โทรศัพท์"),
                                  TextField(
                                    controller: phoneCtl,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1))),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30.0, bottom: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("รหัสผ่าน"),
                                  TextField(
                                    controller: passCtl,
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1))),
                                  ),
                                ],
                              ),
                            ),
                            FilledButton(
                                onPressed: login,
                                style: FilledButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 192, 235, 70),
                                  foregroundColor: Colors.black,
                                ),
                                child: Row(
                                  mainAxisSize:
                                      MainAxisSize.min, //ให้ชิดกับตัวอักษร
                                  children: [
                                    Transform.rotate(
                                      angle: 135 * (3.14159 / 180),
                                      child: const Icon(Icons.key_outlined),
                                    ),
                                    const Text(" Login")
                                  ],
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text("ยังไม่มีบัญชี?"),
                                TextButton(
                                    onPressed: register,
                                    child: const Text("สมัครสมาชิก"))
                              ],
                            ),
                            Text(
                              text,
                              style: TextStyle(
                                  color: getRandomColor(), fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  login() async{
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    log("login pressed");
    LoginPortReq req = LoginPortReq(tel: phoneCtl.text, pass: passCtl.text);
    http
        .post(Uri.parse("$url/login"),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            body: jsonEncode(req))
        .then(
      (value) {
        log(value.body);
        //ตรวจสอบ login
        if (value.statusCode == 200) {
          // Decode json
          var dataRes = jsonDecode(value.body);
          if (dataRes['user']['source'] == 'user') {
            log("user naja");
            Get.to(() => userSender(idx: dataRes['user']['UID'], source: dataRes['user']['source']));
          } else if (dataRes['user']['source'] == 'rider') {
            log("rider nakub");
            Get.to(() => const riderHomePage());
          }
          // reset text
          text = "";
        } else {
          // หากเข้าสู่ระบบไม่สำเร็จ ให้แสดงข้อความแจ้งเตือน
          text = "login failed";
        }
        setState(() {});
      },
    ).catchError((error) {
      log('Error $error');
    });
  }

  register() {
    Get.to(() => const registerPage());
  }
}
