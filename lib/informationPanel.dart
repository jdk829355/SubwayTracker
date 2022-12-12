import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'traindatacontroller.dart';

class InformationPanel extends StatefulWidget {
  final trainInfo;
  const InformationPanel({super.key, this.trainInfo});

  @override
  State<InformationPanel> createState() => _InformationPanelState();
}

class _InformationPanelState extends State<InformationPanel> {
  @override
  Widget build(BuildContext context) {
    Get.put(SimpleController());
    Get.find<SimpleController>()
        .updateCurrentStationNm(widget.trainInfo["statnNm"]);
    return GetBuilder<SimpleController>(builder: ((controller) {
      final status;
      switch (widget.trainInfo["trainSttus"]) {
        case '0':
          status = "진입 중...";
          break;
        case '1':
          status = "도착!";
          break;
        default:
          status = "역을 떠났습니다";
      }

      try {
        if (controller.trainData["statnTnm"] == "신사") {
          return Stack(
            //안내 패널
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 337,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(39),
                  border: Border.all(
                    color: Color(controller.ColorList[controller.line.value]),
                    width: 10,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 4,
                      offset: Offset(0, 5),
                    ),
                  ],
                  color: Color(0xffffffff),
                ),
              ),
              Positioned(
                child: Container(
                  width: 195,
                  height: 27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(controller.ColorList[controller.line.value]),
                      width: 3,
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    "${widget.trainInfo["statnTnm"]}행",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  )),
                ),
              ),
              Positioned(
                top: 65,
                child: Text(
                  "${widget.trainInfo["statnNm"]}",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
                ),
              ),
              Positioned(
                  top: 130,
                  child: Container(
                      width: 260,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 28,
                              width: 70,
                              child: Text(
                                "${controller.LineInfo[controller.scannedLine]["stationNm"][controller.LineInfo[controller.scannedLine]["stationNm"].indexOf(widget.trainInfo["statnNm"]) + 1]}",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 88, 87, 87)),
                              )),
                          const Spacer(),
                          Container(
                              height: 28,
                              width: 70,
                              child: Text(
                                "${controller.LineInfo[controller.scannedLine]["stationNm"][controller.LineInfo[controller.scannedLine]["stationNm"].indexOf(widget.trainInfo["statnNm"]) - 1]}",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 88, 87, 87)),
                              )),
                        ],
                      ))),
              Positioned(
                top: 170,
                child: Container(
                  width: 337,
                  height: 17.0,
                  color: Color(controller.ColorList[controller.line.value]),
                ),
              ),
              Positioned(
                child: Text(
                  "${status}",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black),
                ),
                bottom: 20,
              ),
            ],
          );
        } else {
          return Stack(
            //안내 패널
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 337,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(39),
                  border: Border.all(
                    color: Color(controller.ColorList[controller.line.value]),
                    width: 10,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 4,
                      offset: Offset(0, 5),
                    ),
                  ],
                  color: Color(0xffffffff),
                ),
              ),
              Positioned(
                child: Container(
                  width: 195,
                  height: 27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(controller.ColorList[controller.line.value]),
                      width: 3,
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    "${widget.trainInfo["statnTnm"]}행",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  )),
                ),
              ),
              Positioned(
                top: 65,
                child: Text(
                  "${widget.trainInfo["statnNm"]}",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
                ),
              ),
              Positioned(
                  top: 130,
                  child: Container(
                      width: 260,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 28,
                              width: 70,
                              child: Text(
                                "${controller.LineInfo[controller.scannedLine]["stationNm"][controller.LineInfo[controller.scannedLine]["stationNm"].indexOf(widget.trainInfo["statnNm"]) - 1]}",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 88, 87, 87)),
                              )),
                          const Spacer(),
                          Container(
                              height: 28,
                              width: 70,
                              child: Text(
                                "${controller.LineInfo[controller.scannedLine]["stationNm"][controller.LineInfo[controller.scannedLine]["stationNm"].indexOf(widget.trainInfo["statnNm"]) + 1]}",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 88, 87, 87)),
                              )),
                        ],
                      ))),
              Positioned(
                top: 170,
                child: Container(
                  width: 337,
                  height: 17.0,
                  color: Color(controller.ColorList[controller.line.value]),
                ),
              ),
              Positioned(
                child: Text(
                  "${status}",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black),
                ),
                bottom: 20,
              ),
            ],
          );
        }
      } catch (e) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          width: 337,
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(39),
            border: Border.all(
              color: Color(controller.ColorList[controller.line.value]),
              width: 10,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3f000000),
                blurRadius: 4,
                offset: Offset(0, 5),
              ),
            ],
            color: Color(0xffffffff),
          ),
        );
      }
    }));
  }
}
