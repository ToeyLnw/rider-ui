import 'package:call_your_rider/page/appBar.dart';
import 'package:call_your_rider/page/riderDrawer.dart';
import 'package:call_your_rider/page/userDrawer.dart';
import 'package:flutter/material.dart';
class riderHomePage extends StatefulWidget {
  const riderHomePage({super.key});

  @override
  State<riderHomePage> createState() => _riderHomePageState();
}

class _riderHomePageState extends State<riderHomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(205, 192, 253, 70),
        appBar: const appBarWidget(),
        drawer: const riderDrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "รายการออร์เดอร์",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
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
                        Expanded(
                          // ใช้ Expanded ที่นี่
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.storefront),
                                  SizedBox(
                                      width:
                                          8), // เพิ่มระยะห่างระหว่าง icon และ text
                                  Expanded(
                                    child: Text(
                                      "เสี่ยโจ้",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ), //Row1
                              Row(
                                children: [
                                  const SizedBox(width: 13),
                                  Container(
                                    width: 1,
                                    height: 50,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 20),
                                  const Expanded(
                                    child: Text(
                                      "slow express 12/33 ซอย 5 ถนนวันจันทร์ ต.ประตูน้ำ อ.เมือง จ.มหาสารคราม",
                                      style: TextStyle(fontSize: 14),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ), //Row2
                              // const SizedBox(height: 8),
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "กนกพร",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ), //Row3
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 35),
                                  Expanded(
                                    child: Text(
                                      "หอพักสุรชัย 310 ต.หนองพล อ.กิจณีย จ.มหาสารคราม",
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
                                onPressed: takeOrder,
                                child: const Text("รับงานนี้"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void takeOrder(){}
}