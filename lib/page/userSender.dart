import 'package:call_your_rider/page/appBar.dart';
import 'package:call_your_rider/page/userDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class userSender extends StatefulWidget {
  int idx = 0;
  String? source = "";
  userSender({super.key, required this.idx, this.source});

  @override
  State<userSender> createState() => _userSender();
}

class _userSender extends State<userSender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(205, 192, 253, 70),
      appBar: const appBarWidget(),
      drawer: userDrawerWidget(idx: widget.idx, source: widget.source,),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  // กรณีไม่มีสินค้า
                    // width: MediaQuery.of(context).size.width * 0.7,
                    // child: Card(
                    // elevation: 4,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       children: [
                    //         const Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Text(
                    //             "ยังไม่มีสินค้าส่งออก",
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.bold),
                    //           ),
                    //         ),
                    //         FilledButton(
                    //             onPressed: () {},
                    //             child: const Text("ส่งของเลย!"))
                    //       ],
                    //     ),
                    //   ),
                    // )
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // ทำให้ icon กับ text align กัน
                      children: [
                        const Expanded(
                          // ใช้ Expanded ที่นี่
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.timer_outlined),
                                  SizedBox(
                                      width:
                                          8), // เพิ่มระยะห่างระหว่าง icon และ text
                                  Expanded(
                                    child: Text(
                                      "รอไรเดอร์มารับสินค้า",
                                      style: TextStyle(
                                          fontSize: 18,
                                          ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ), //Row1
                              Row(
                                children: [
                                  SizedBox(width: 35),
                                  Expanded(
                                    child: Text(
                                      "ชื่อสินค้า: LC Robin",
                                      style: TextStyle(fontSize: 18),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ), //Row2
                              SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.storefront_outlined),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "ผู้ส่ง เสี่ยโจ้",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ), //Row3
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 35),
                                  Expanded(
                                    child: Text(
                                      "ร้านหมูตู้ ช็อป 310 ต.หนองพล อ.กิจณีย จ.มหาสารคราม",
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
                              'https://upload-os-bbs.hoyolab.com/upload/2024/05/07/248396272/879b0dac419413dbdb8edbc71f4b1355_2044136382544371185.png',
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
                    ),
                    ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
