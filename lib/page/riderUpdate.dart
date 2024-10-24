import 'package:call_your_rider/page/appBar.dart';
import 'package:call_your_rider/page/riderDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class riderUpdatePage extends StatefulWidget {
  const riderUpdatePage({super.key});

  @override
  State<riderUpdatePage> createState() => _riderUpdatePageState();
}

class _riderUpdatePageState extends State<riderUpdatePage> {
  TextEditingController nameCtl = TextEditingController();
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
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.network(
                            'https://i.pinimg.com/736x/11/5e/b9/115eb9d1ff5a8d32c9000d3ec418d014.jpg',
                            height: 100,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Rider",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                            const Text("ที่อยู่"),
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
                            const Text("ทะเบียนรถ"),
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
                          children: [
                            const Text("รหัสผ่าน",style: TextStyle(fontSize: 20),),
                            FilledButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: 'เปลี่ยนรหัสผ่าน',
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: nameCtl,
                                                  keyboardType: TextInputType.text,
                                                  decoration: const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 1)),
                                                              hintText: 'รหัสผ่านเก่า'),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                TextField(
                                                  controller: nameCtl,
                                                  keyboardType: TextInputType.text,
                                                  decoration: const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 1)),
                                                              hintText: 'รหัสผ่านใหม่'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      barrierDismissible: false,
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('ยกเลิก')),
                                        FilledButton(
                                            onPressed: () {},
                                            child: const Text('ตกลง')),
                                      ]);
                                },
                                child: const Text('แก้ไขรหัสผ่าน')),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 192, 253, 70),
                                  foregroundColor:
                                      const Color.fromARGB(255, 0, 0, 0),
                                  side: const BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 1),
                                ),
                              child: const Text("บันทึกข้อมูล")),
                        )
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
}
