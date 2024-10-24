import 'dart:convert';
import 'dart:developer';
import 'package:call_your_rider/config/config.dart';
import 'package:call_your_rider/model/response/order_get_res.dart';
import 'package:call_your_rider/page/appBar.dart';
import 'package:call_your_rider/page/login.dart';
import 'package:call_your_rider/page/userDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class userReceiver extends StatefulWidget {
  final int idx;
  userReceiver({super.key, required this.idx});

  @override
  State<userReceiver> createState() => _userReceiverState();
}

class _userReceiverState extends State<userReceiver> {
  String url = "";
  late List<OrderGetRes> orderResponse = []; // ประกาศ orderGetRes เป็น List
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
      drawer: userDrawerWidget(idx: widget.idx),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "สินค้านำเข้า",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FutureBuilder(
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            FilledButton(
                                onPressed: () {},
                                child: const Text("ส่งของเลย!")),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  // แสดงรายการสินค้าที่ได้รับ
                  return ListView.builder(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.timer_outlined),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            order.name,
                                            style:
                                                const TextStyle(fontSize: 18),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const SizedBox(width: 35),
                                        Expanded(
                                          child: Text(
                                            "ชื่อสินค้า: ${order.name}", // ใช้ข้อมูลจริง
                                            style:
                                                const TextStyle(fontSize: 18),
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
                                        const Icon(Icons.storefront_outlined),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "ผู้ส่ง: ${order.senderName}", // ใช้ข้อมูลจริง
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        SizedBox(width: 35),
                                        Expanded(
                                          child: Text(
                                            "ร้าน: ร้านหมูตู้ ช็อป 310 ต.หนองพล อ.กิจณีย จ.มหาสารคราม",
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
                                    order.img, // เปลี่ยนเป็น URL ของภาพจริง
                                    width: 90,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: FilledButton(
                                      onPressed: () {},
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
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> loadDataAsync() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var res = await http.get(Uri.parse('$url/order/reciever/${widget.idx}'));
    log(res.body);

    // ตรวจสอบสถานะการร้องขอ
    if (res.statusCode == 200) {
      // ใช้ orderResponse ที่ประกาศไว้ในระดับคลาส
      orderResponse = List<OrderGetRes>.from(
        json.decode(res.body).map((x) => OrderGetRes.fromJson(x)),
      );
      log(orderResponse.length.toString());
      setState(() {}); // อัปเดต UI
    } else {
      log('การร้องขอข้อมูลล้มเหลว: สถานะ HTTP ${res.statusCode}');
    }
  }
}
