import 'dart:convert';
import 'dart:developer';

import 'package:call_your_rider/config/config.dart';
import 'package:call_your_rider/model/response/order_get_res.dart';
import 'package:call_your_rider/model/response/user_data_get_res.dart';
import 'package:call_your_rider/page/appBar.dart';
import 'package:call_your_rider/page/details.dart';
import 'package:call_your_rider/page/sending.dart';
import 'package:call_your_rider/page/userDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class userSender extends StatefulWidget {
  int idx = 0;
  String? source = "";
  userSender({super.key, required this.idx, this.source});

  @override
  State<userSender> createState() => _userSender();
}

class _userSender extends State<userSender> {
  String url = "";
  late UserDataGetRes userDataGetRes;
  List<OrderGetRes> orderResponse = []; // เปลี่ยนจาก late เป็น List ปกติ
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(205, 192, 253, 70),
      appBar: const appBarWidget(),
      drawer: userDrawerWidget(idx: widget.idx, source: widget.source),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "สินค้าส่งออก",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FutureBuilder(
              future: loadData,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (orderResponse.isEmpty) {
                  // กรณีไม่มีสินค้า
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "ยังไม่มีสินค้าส่งออก",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FilledButton(
                              onPressed: sending,
                              child: const Text("ส่งของเลย!"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  // แสดงรายการสินค้าที่ได้รับ
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          // width: double.infinity,
                          child: FilledButton(
                            onPressed: sending,
                            child: const Text("ส่งสินค้าเพิ่ม"),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderResponse.length,
                        itemBuilder: (context, index) {
                          final order = orderResponse[index];
                          return Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.timer_outlined),
                                            const SizedBox(width: 8),
                                            Flexible(
                                              child: Text(
                                                order.statusMessage,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(width: 35),
                                            Expanded(
                                              child: Text(
                                                "ชื่อสินค้า: ${order.name}",
                                                style: const TextStyle(
                                                    fontSize: 18),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                                Icons.storefront_outlined),
                                            const SizedBox(width: 8),
                                            Flexible(
                                              child: Text(
                                                "ผู้ส่ง: ${order.senderName}",
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 35),
                                            Expanded(
                                              child: Text(
                                                order.origin ?? "",
                                                softWrap: true,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Image.network(
                                        order.img,
                                        width: 90,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: FilledButton(
                                          onPressed: () {
                                            Get.to(() =>
                                                DetailsPage(idx: widget.idx, oid: order.oid,));
                                          },
                                          child: const Text("ดูรายละเอียด"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  sending() {
    Get.to(() => SendingPage(idx: widget.idx));
  }

  Future<void> loadDataAsync() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var res = await http.get(Uri.parse('$url/order/sender/${widget.idx}'));
    log(res.body);

    if (res.statusCode == 200) {
      orderResponse = List<OrderGetRes>.from(
        json.decode(res.body).map((x) => OrderGetRes.fromJson(x)),
      );
      log(orderResponse.length.toString());
      setState(() {}); // อัปเดต UI
    } else {
      log('การร้องขอข้อมูลล้มเหลว: สถานะ HTTP ${res.statusCode}');
    }

    res = await http.get(Uri.parse('$url/user/find/${widget.idx}'));
    var data = jsonDecode(res.body);
    userDataGetRes = UserDataGetRes.fromJson(data[0]);
  }
}
