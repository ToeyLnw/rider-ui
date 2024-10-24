import 'dart:convert';
import 'dart:developer';
import 'package:call_your_rider/config/config.dart';
import 'package:call_your_rider/model/request/register_post_req.dart';
import 'package:call_your_rider/page/login.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  String role = "";
  String text = "", url = "";
  XFile? image;
  Color riderButton = const Color.fromARGB(255, 197, 197, 197);
  Color riderTextButton = const Color.fromARGB(255, 0, 0, 0);
  Color userButton = const Color.fromARGB(255, 197, 197, 197);
  Color userTextButton = const Color.fromARGB(255, 0, 0, 0);

  final ImagePicker picker = ImagePicker();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController passCtl = TextEditingController();
  TextEditingController addrCtl = TextEditingController();
  // TextEditingController nameCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(205, 192, 253, 70),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
              height: 100,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 32.0),
                        child: Text(
                          "สมัครสมาชิก",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ชื่อผู้ใช้"),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextField(
                              controller: nameCtl,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1))),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("เบอร์โทรศัพท์"),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextField(
                              controller: phoneCtl,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1))),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("รหัสผ่าน"),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextField(
                              controller: passCtl,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1))),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ที่อยู่"),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextField(
                              controller: addrCtl,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              const Text("รูปภาพ"),
                              FilledButton(
                                  onPressed: gallery,
                                  child: const Text('เลือกรูปภาพ')),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: (image != null)
                                ? Image.file(
                                    File(image!.path),
                                    width: 120,
                                  )
                                : Container(),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "ฉันคือ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FilledButton(
                              onPressed: user,
                              style: FilledButton.styleFrom(
                                backgroundColor: userButton,
                                foregroundColor: userTextButton,
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 1),
                              ),
                              child: const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.person),
                                  ),
                                  Text("User"),
                                ],
                              )),
                          FilledButton(
                              onPressed: rider,
                              style: FilledButton.styleFrom(
                                backgroundColor: riderButton,
                                foregroundColor: riderTextButton,
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 1),
                              ),
                              child: const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child:
                                        Icon(Icons.sports_motorsports_rounded),
                                  ),
                                  Text("rider"),
                                ],
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: [
                            FilledButton(
                              onPressed: register,
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 192, 253, 70),
                                foregroundColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 1),
                              ),
                              child: const Text("สมัครสมาชิก"),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("มีบัญชีแล้ว?"),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const loginPage());
                            },
                            child: const Text("เข้าสู่ระบบ"),
                          )
                        ],
                      ),
                      Text(text)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  gallery() async {
    log("Opening gallery...");
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      log(image!.path.toString());
      setState(() {});
    } else {
      log('No Image');
    }
  }

  user() {
    log("user pressed");
    role = "user";
    setState(() {
      userButton = Colors.red;
      userTextButton = Colors.white;
      riderButton = const Color.fromARGB(255, 197, 197, 197);
      riderTextButton = const Color.fromARGB(255, 0, 0, 0);
    });
  }

  rider() {
    log("rider pressed");
    role = "rider";
    setState(() {
      riderButton = Colors.red;
      riderTextButton = Colors.white;
      userButton = const Color.fromARGB(255, 197, 197, 197);
      userTextButton = const Color.fromARGB(255, 0, 0, 0);
    });
  }

  register() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    log("register pressed");

    if (image != null) {
      if (phoneCtl.text.isNotEmpty && passCtl.text.isNotEmpty) {
        try {
          String fileExtension = image!.path.split('.').last.toLowerCase();
          if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
            // สร้าง MultipartRequest สำหรับอัปโหลดภาพไปยัง backend
            var request = http.MultipartRequest(
              'POST',
              Uri.parse("$url/file"), // URL ที่ใช้ในการอัปโหลดไฟล์ไปยัง backend
            );

            // เพิ่มไฟล์ภาพเข้าไปใน request
            request.files.add(
              await http.MultipartFile.fromPath('filename', image!.path),
            );

            // ส่ง request ไปที่ backend
            var response = await request.send();

            // ตรวจสอบการตอบกลับ
            if (response.statusCode == 200) {
              var responseBody = await response.stream.bytesToString();
              var jsonResponse = json.decode(responseBody);

              // ตรวจสอบ URL ของรูปภาพที่ถูกอัปโหลดสำเร็จ
              String imageUrl = jsonResponse['downloadURL'];
              log('Image uploaded to backend: $imageUrl');

              // ส่งข้อมูลการลงทะเบียน
              RegisterPostReq req = RegisterPostReq(
                tel: phoneCtl.text,
                pass: passCtl.text,
                name: nameCtl.text,
                address: addrCtl.text,
                img: imageUrl,
              );

              // ส่งข้อมูลการลงทะเบียนไปยัง backend
              if (role == "user") {
                var registrationResponse = await http.post(
                  Uri.parse("$url/user/add"),
                  headers: {"Content-Type": "application/json; charset=utf-8"},
                  body: registerPostReqToJson(req),
                );
                if (registrationResponse.statusCode == 200) {
                  log('Registration successful');
                  Get.to(() => const loginPage());
                } else {
                  log('Registration failed: ${registrationResponse.body}');
                }
              } else if (role == "rider") {
                var registrationResponse = await http.post(
                  Uri.parse("$url/rider/add"),
                  headers: {"Content-Type": "application/json; charset=utf-8"},
                  body: registerPostReqToJson(req),
                );
                if (registrationResponse.statusCode == 200) {
                  log('Registration successful');
                  Get.to(() => const loginPage());
                } else {
                  log('Registration failed: ${registrationResponse.body}');
                }
              }
            } else {
              log('Failed to upload image: ${response.statusCode}');
            }
          }
        } catch (error) {
          log('Error uploading to backend: $error');
        }
      } else {
        setState(() {
          text = "กรอกชื่อและรหัสผ่านให้ครบถ้วน";
        });
      }
    } else {
      setState(() {
        text = "โปรดใส่รูปภาพ";
      });
    }
  }
}
