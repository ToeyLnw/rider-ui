import 'dart:convert';
import 'dart:developer';

import 'package:call_your_rider/config/config.dart';
import 'package:call_your_rider/model/response/rider_data_get_res.dart';
import 'package:call_your_rider/model/response/user_data_get_res.dart';
import 'package:call_your_rider/page/map.dart';
import 'package:call_your_rider/page/userProfile.dart';
import 'package:call_your_rider/page/userReceiver.dart';
import 'package:call_your_rider/page/userSender.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class userDrawerWidget extends StatefulWidget {
  final int idx; // ใช้รับค่าจาก constructor
  final String? source; // เพิ่มตัวแปร source

  userDrawerWidget({super.key, required this.idx, this.source});

  @override
  _userDrawerWidgetState createState() => _userDrawerWidgetState();
}

class _userDrawerWidgetState extends State<userDrawerWidget> {
  String url = "";
  late Future<void> loadData;
  late UserDataGetRes userDataGetRes;

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync(); // เรียกใช้ฟังก์ชันโหลดข้อมูล
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 0, 10),
        child: FutureBuilder(
          future: loadData,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // Load Done
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ListTile(
                    title: Image.asset(
                      'assets/image/SE_logo.png',
                      width: 200,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.network(
                        userDataGetRes.img,
                        width: 60.0, // ความกว้าง
                        height: 60.0, // ความสูง
                        fit: BoxFit.cover, //ปรับให้เข้ากับขนาด
                      ),
                    ),
                    title: Text(
                      userDataGetRes.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      userDataGetRes.tel,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_circle_outlined,
                      size: 50,
                    ),
                    title: const Text(
                      'บัญชีของคุณ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfilePage(
                              idx: widget.idx, // ใช้ widget.idx
                            ),
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.local_shipping_outlined,
                      size: 50,
                    ),
                    title: const Text(
                      'สินค้าส่งออก',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userSender(
                              idx: widget.idx, // ใช้ widget.idx
                            ),
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.inventory_2_outlined,
                      size: 50,
                    ),
                    title: const Text(
                      'สินค้านำเข้า',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userReceiver(
                              idx: widget.idx, // ใช้ widget.idx
                            ),
                          ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      size: 50,
                    ),
                    title: const Text(
                      'ออกจากระบบ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                    },
                  ),
                ),Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      size: 50,
                    ),
                    title: const Text(
                      'map',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GPSandMapPage(),
                          ));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
  // Async function for api call
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
