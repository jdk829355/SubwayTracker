import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subwaytracker/scannedPage.dart';
import 'package:swipe/swipe.dart';
import 'traindatacontroller.dart';
import 'informationPanel.dart';
import 'navigationBar.dart';
import 'miniIndicator.dart';
import 'local_notification.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotification().requestPermission();
    Get.put(SimpleController());
    Get.find<SimpleController>().initBeacoon();
    Get.find<SimpleController>().scanBeacon();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SimpleController());
    return Scaffold(body: Center(child: GetBuilder<SimpleController>(
      builder: (controller) {
        return SafeArea(
            child: Container(
                //전체 화면
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          if (Get.find<SimpleController>().scannedLine !=
                              "SubwayTracker") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScannedPage()));
                          }
                        },
                        child: MiniIndicator()),
                    SizedBox(
                      //높이 여백(padding역할)
                      width: double.infinity,
                      height: 30,
                    ),
                  ],
                )));
      },
    )));
  }
}
