import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:call_your_rider/model/response/user_data_get_res.dart';
import 'package:call_your_rider/page/appBar.dart';
import 'package:call_your_rider/page/userDrawer.dart';
import 'package:get/get.dart';
import 'package:call_your_rider/config/config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UserProfilePage extends StatefulWidget {
  final int idx; // ใช้รับค่าจาก constructor
  final String? source; // เพิ่มตัวแปร source

  const UserProfilePage({super.key, required this.idx, this.source});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String text = "", url = "";
  XFile? image;
  late Future<void> loadData;
  late UserDataGetRes userDataGetRes;

  final ImagePicker picker = ImagePicker();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController passCtl = TextEditingController();
  TextEditingController addrCtl = TextEditingController();
  // TextEditingController nameCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync(); // เรียกใช้ฟังก์ชันโหลดข้อมูล
  }

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
                              children: [
                                userDataGetRes.img.isNotEmpty
                                    ? ClipOval(
                                        child: Image.network(
                                          userDataGetRes.img,
                                          height: 90,
                                        ),
                                      )
                                    : const Text(
                                        "ไม่มีรูปภาพ"), // แสดงข้อความถ้าไม่มี URL ของรูปภาพ
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                userDataGetRes.name,
                                style: const TextStyle(
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("พิกัด GPS ของคุณ"),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(userDataGetRes.gps),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Column(
                                children: [
                                  FilledButton(
                                    onPressed: () {},
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
                            Text(text)
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

  Future<void> loadDataAsync() async {
    try {
      var config = await Configuration.getConfig();
      url = config['apiEndpoint'];
      var res = await http.get(Uri.parse('$url/user/find/${widget.idx}'));

      // Decode ข้อมูล string ที่ได้มา
      var data = jsonDecode(res.body);
      userDataGetRes = UserDataGetRes.fromJson(data[0]);
      nameCtl.text = userDataGetRes.name;
      phoneCtl.text = userDataGetRes.tel;
      addrCtl.text = userDataGetRes.address;
      setState(() {}); // อัพเดต UI
    } catch (e) {
      log("เกิดข้อผิดพลาด: $e");
    }
  }
}
