import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'traindatacontroller.dart';

class MiniIndicator extends StatefulWidget {
  const MiniIndicator({super.key});

  @override
  State<MiniIndicator> createState() => _MiniIndicatorState();
}

class _MiniIndicatorState extends State<MiniIndicator> {
  @override
  Widget build(BuildContext context) {
    if (Get.find<SimpleController>().scannedLine != "SubwayTracker") {
      return Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 40,
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 1),
                width: 361,
                height: 47,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(Get.find<SimpleController>()
                        .ColorList[Get.find<SimpleController>().line.value]),
                    width: 5,
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "현위치",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${Get.find<SimpleController>().currentStationNm}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ))),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 40,
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
                padding: const EdgeInsets.only(right: 10, left: 3),
                width: 361,
                height: 47,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(0xffd3d3d3),
                    width: 5,
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "내리세요?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ))),
      );
    }
  }
}
