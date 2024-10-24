import 'package:call_your_rider/page/riderHome.dart';
import 'package:call_your_rider/page/riderUpdate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class riderDrawerWidget extends StatelessWidget {
  const riderDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 0, 10),
        child: Column(
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
                    'https://i.redd.it/weve-done-it-people-%C3%BCbel-eats-is-real-now-v0-kz02x3thtz0d1.jpg?width=1000&format=pjpg&auto=webp&s=9ef30315209450ac6c4ab02155eec6955eebefab',
                    width: 60.0, // ความกว้าง
                    height: 60.0, // ความสูง
                    fit: BoxFit.cover, //ปรับให้เข้ากับขนาด
                  ),
                ),
                title: const Text('Ubel Uber', style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: const Text("0999999999", style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  size: 50,
                ),
                title: const Text(
                  'หน้าแรก',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(() => const riderHomePage());
                },
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(() => const riderUpdatePage());
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
