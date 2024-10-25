import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:call_your_rider/config/config.dart';
import 'package:call_your_rider/model/request/order_post_req.dart';
import 'package:call_your_rider/model/response/user_data_get_res.dart';
import 'package:call_your_rider/page/appBar.dart';
import 'package:call_your_rider/page/userDrawer.dart';
import 'package:call_your_rider/page/userSender.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SendingPage extends StatefulWidget {
  final int idx; // ใช้รับค่าจาก constructor

  const SendingPage({super.key, required this.idx});

  @override
  State<SendingPage> createState() => _SendingPageState();
}

class _SendingPageState extends State<SendingPage> {
  String text = "", url = "";
  late Future<void> loadData;
  late UserDataGetRes userDataGetRes;
  late UserDataGetRes userDataGetRes2;
  XFile? image;
  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync(); // เรียกใช้ฟังก์ชันโหลดข้อมูล
  }

  final ImagePicker picker = ImagePicker();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController descriptionCtl = TextEditingController();
  TextEditingController addrCtl = TextEditingController();
  // TextEditingController nameCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(205, 192, 253, 70),
      appBar: const appBarWidget(),
      drawer: userDrawerWidget(idx: widget.idx),
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
                  child: FutureBuilder(
                      future: loadData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("ชื่อสินค้า"),
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
                                const Text("เบอร์โทรศัพท์ผู้รับ"),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        // ใช้ Expanded เพื่อให้ TextField ขยายเต็มที่
                                        child: TextField(
                                          controller: phoneCtl,
                                          keyboardType: TextInputType.phone,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              8), // เว้นระยะระหว่าง TextField และ Icon
                                      IconButton(
                                          icon: const Icon(
                                              Icons.find_in_page_outlined),
                                          onPressed: findtel),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Text(text),
                                ),
                                const Text("คำอธิบายสินค้า"),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: TextField(
                                    controller: descriptionCtl,
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
                                    const Text("รูปภาพสินค้า"),
                                    FilledButton(
                                        onPressed: camera,
                                        child: const Text('ถ่ายรูปภาพ')),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Column(
                                children: [
                                  FilledButton(
                                    onPressed: sendOrder,
                                    style: FilledButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 192, 253, 70),
                                      foregroundColor:
                                          const Color.fromARGB(255, 0, 0, 0),
                                      side: const BorderSide(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          width: 1),
                                    ),
                                    child: const Text("บันทึกข้อมูล"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendOrder() async {
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

          OrderPostReq req = OrderPostReq(
              senderId: widget.idx,
              recieverId: userDataGetRes2.uid,
              name: nameCtl.text,
              description: descriptionCtl.text,
              origin: userDataGetRes.address,
              destination: userDataGetRes2.address,
              status: 1,
              img: imageUrl);
          var config = await Configuration.getConfig();
          url = config['apiEndpoint'];
          var res = await http.post(
            Uri.parse("$url/order/add"),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            body: orderPostReqToJson(req),
          );
          if (res.statusCode == 200) {
            log('Registration successful');
            Get.to(() => userSender(idx: widget.idx));
          } else {
            log('Registration failed: ${res.body}');
          }
        }
      }
    } catch (e) {
      log("เกิดข้อผิดพลาด: $e");
    }
  }

  camera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      log(image!.path.toString());
      setState(() {});
    } else {
      log('No Image');
    }
  }

  findtel() async {
    try {
      var config = await Configuration.getConfig();
      url = config['apiEndpoint'];
      var res = await http.get(Uri.parse('$url/user/findTel/${phoneCtl.text}'));

      // Decode ข้อมูล string ที่ได้มา
      var data = jsonDecode(res.body);
      userDataGetRes2 = UserDataGetRes.fromJson(data[0]);
      text =
          "ชื่อ: ${userDataGetRes2.name}, เบอร์: ${userDataGetRes2.tel}, ที่อยู่: ${userDataGetRes2.address}";
      setState(() {}); // อัพเดต UI
    } catch (e) {
      log("เกิดข้อผิดพลาด: $e");
    }
  }

  Future<void> loadDataAsync() async {
    try {
      var config = await Configuration.getConfig();
      url = config['apiEndpoint'];
      var res = await http.get(Uri.parse('$url/user/find/${widget.idx}'));

      // Decode ข้อมูล string ที่ได้มา
      var data = jsonDecode(res.body);
      userDataGetRes = UserDataGetRes.fromJson(data[0]);

      setState(() {}); // อัพเดต UI
    } catch (e) {
      log("เกิดข้อผิดพลาด: $e");
    }
  }
}
