import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subwaytracker/scannedPage.dart';
import 'traindatacontroller.dart';
import 'scannedPage.dart';

class StatusWidgetInMainPage extends StatefulWidget {
  const StatusWidgetInMainPage({super.key});

  @override
  State<StatusWidgetInMainPage> createState() => _StatusWidgetInMainPageState();
}

class _StatusWidgetInMainPageState extends State<StatusWidgetInMainPage> {
  @override
  Widget build(BuildContext context) {
    if (Get.find<SimpleController>().scannedLine == "SubwayTracker") {
      return Container(
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
        child: Image(
          fit: BoxFit.fill,
          width: 169,
          height: 169,
          image: AssetImage('loader.gif'),
        ),
      );
    } else {
      return Container(
          alignment: Alignment.topLeft,
          width: 169,
          height: 169,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3f000000),
                  blurRadius: 3,
                  offset: Offset(0, 4),
                )
              ]),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScannedPage()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            height: 20,
                            color: Color(Get.find<SimpleController>().ColorList[
                                Get.find<SimpleController>().line.value]),
                          ),
                        ),
                        Stack(alignment: Alignment.center, children: [
                          Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color(Get.find<SimpleController>()
                                        .ColorList[
                                    Get.find<SimpleController>().line.value]),
                                width: 3,
                              ),
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${Get.find<SimpleController>().scannedLine}",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ]),
                        Flexible(
                          child: Container(
                            height: 20,
                            color: Color(Get.find<SimpleController>().ColorList[
                                Get.find<SimpleController>().line.value]),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  width: double.infinity,
                  height: 35,
                ),
                Visibility(
                  child: Container(
                    child: Text(
                      "${Get.find<SimpleController>().stationToGetOff == "none" ? "터치하여 내릴역 선택" : Get.find<SimpleController>().stationToGetOff + "행"}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  visible: (Get.find<SimpleController>().scannedLine !=
                      "SubwayTracker"),
                )
              ],
            ),
          ));
    }
  }
}
