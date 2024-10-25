import 'dart:convert';
import 'dart:developer';

import 'package:call_your_rider/config/config.dart';
import 'package:call_your_rider/model/response/order1_get_res.dart';
import 'package:call_your_rider/model/response/order_get_res.dart';
import 'package:call_your_rider/model/response/user_data_get_res.dart';
import 'package:call_your_rider/page/appBar.dart';
import 'package:call_your_rider/page/userDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final int idx; // ใช้รับค่าจาก constructor
  final int oid;
  const DetailsPage({super.key, required this.idx, required this.oid});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String text = "", url = "";
  late Future<void> loadData;
  late UserDataGetRes userDataGetRes;
  late List<Order1GetRes> order1GetRes = [];
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
                                          order1GetRes[0].img,
                                          height: 90,
                                        ),
                                      )
                                    : const Text("ไม่มีรูปภาพ"),
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

  Future<void> loadDataAsync() async {
  try {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    // ส่งคำขอแรกเพื่อนำข้อมูลผู้ใช้
    var userRes = await http.get(Uri.parse('$url/user/find/${widget.idx}'));
    
    if (userRes.statusCode == 200) {
      var userData = jsonDecode(userRes.body);
      
      // ตรวจสอบว่า data ไม่ว่างเปล่า
      if (userData.isNotEmpty) {
        userDataGetRes = UserDataGetRes.fromJson(userData[0]); // ตรวจสอบการสร้างออบเจ็กต์
      } else {
        log("ไม่พบข้อมูลผู้ใช้");
      }
    } else {
      log("เกิดข้อผิดพลาดในการดึงข้อมูลผู้ใช้: ${userRes.statusCode}");
    }

    // ส่งคำขอที่สองเพื่อนำข้อมูลการสั่งซื้อ
    var orderRes = await http.get(Uri.parse('$url/order/details/${widget.oid}'));
    log(orderRes.body);
    if (orderRes.statusCode == 200) {
      var orderData = jsonDecode(orderRes.body);
      
      // ตรวจสอบว่า data ไม่ว่างเปล่า
      if (orderData.isNotEmpty) {
        // ใช้ orderResponse ที่ประกาศไว้ในระดับคลาส
      order1GetRes = List<Order1GetRes>.from(
        json.decode(orderRes.body).map((x) => OrderGetRes.fromJson(x)),
      );
      } else {
        log("ไม่พบข้อมูลการสั่งซื้อ");
      }
    } else {
      log("เกิดข้อผิดพลาดในการดึงข้อมูลการสั่งซื้อ: ${orderRes.statusCode}");
    }

    setState(() {}); // อัพเดต UI
  } catch (e) {
    log("เกิดข้อผิดพลาด: $e");
  }
}


}
