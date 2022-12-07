import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'traindatacontroller.dart';
import 'main.dart';
import 'scannedpage.dart';

class MyNavigationBar extends StatefulWidget {
  //navigationbar 커스텀
  const MyNavigationBar({super.key, this.line = 'notScanned'});
  final line;
  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(SimpleController());
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 35,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          "목적지 선택 및 하차알림",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
