import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subwaytracker/scannedPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'traindatacontroller.dart';
import 'miniIndicator.dart';
import 'local_notification.dart';
import 'indicatorWidgetInMainPage.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'mapWidget.dart';

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
    if (Get.find<SimpleController>().currentStationNm.string ==
        Get.find<SimpleController>().stationToGetOff) {
      Get.find<SimpleController>().arrived = true;
      Get.find<SimpleController>().update();
    }
    return Scaffold(body: Center(child: GetBuilder<SimpleController>(
      builder: (controller) {
        controller.update;
        return Container(
            //전체 화면
            width: double.infinity,
            height: double.infinity,
            color: Color(0xF4F4F4),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
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
                const SizedBox(
                  //높이 여백(padding역할)
                  width: double.infinity,
                  height: 20,
                ),
                Expanded(
                    child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  children: [
                    Container(
                        width: 353,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                clipBehavior: Clip.antiAlias,
                                width: 169,
                                height: 169,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x3f000000),
                                      blurRadius: 3,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: MaterialButton(
                                    onPressed: () {
                                      launchUrl(
                                        Uri.parse(
                                            'https://github.com/jdk829355'),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "제작자",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("github.com/jdk829355",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400))
                                      ],
                                    ))),
                            Spacer(),
                            StatusWidgetInMainPage()
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 10, top: 25),
                        alignment: Alignment.centerLeft,
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "현재 역 근처에는 무엇이 있을까요?",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "지도로 알아보세요(자세히 보려면 google 터치)",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                    GetBuilder<SimpleController>(builder: (controller) {
                      return ScrollMapWidget();
                    })
                  ],
                ))
              ],
            ));
      },
    )));
  }
}
