import 'package:flutter/material.dart';

class appBarWidget extends StatefulWidget implements PreferredSizeWidget{
  const appBarWidget({super.key});

  @override
  State<appBarWidget> createState() => _appBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}

class _appBarWidgetState extends State<appBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/image/SE_logo.png',
                    width: 200,
                  ),
                  // ClipOval(
                  //   child: Image.network(
                  //     'https://i.pinimg.com/736x/11/5e/b9/115eb9d1ff5a8d32c9000d3ec418d014.jpg',
                  //     height: 70,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}