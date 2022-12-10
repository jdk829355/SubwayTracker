import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'traindatacontroller.dart';
import 'package:flutter/cupertino.dart';
import 'traindatacontroller.dart';
import 'local_notification.dart';

class StationPicker extends StatefulWidget {
  const StationPicker({super.key});

  @override
  State<StationPicker> createState() => _StationPickerState();
}

class _StationPickerState extends State<StationPicker> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection(Get.find<SimpleController>().scannedLine)
      .snapshots();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(SimpleController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SimpleController>(builder: (controller) {
      return StreamBuilder(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Loading"));
            }

            if (snapshot.hasData) {
              final info = snapshot.data!.docs
                  .where((e) =>
                      e["statnNm"] ==
                      Get.find<SimpleController>().currentStationNm)
                  .toList()[0];
              var stationList;
              final stationToGetOff;

              if (info["statnNm"] == controller.stationToGetOff) {
                Get.back();
                LocalNotification()
                    .sampleNotification(controller.stationToGetOff);
                controller.arrived = true;
                controller.stationToGetOff = "none";
              } else {
                stationList = controller.slicingStatonList();
                controller.StringListToWidgetList(stationList);
              }

              if (controller.selectedStation == "..") {
                controller.selectedStation = stationList[0];
              }

              if (controller.currentStationList.length == 1) {
                controller.selectedStation = info["statnTnm"];
              }

              if (controller.stationToGetOff == "none") {
                stationToGetOff = "어디로 갈까요?";
              } else {
                stationToGetOff = controller.stationToGetOff;
              }

              return Stack(
                children: [
                  Opacity(
                      opacity: 0.4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0x66d3d3d3),
                        ),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Padding(
                            padding: EdgeInsets.only(right: 30, left: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                    flex: 4,
                                    child: Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          const Text(
                                            "목적지",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            width: 120,
                                          ),
                                          Text(
                                            stationToGetOff,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: 50,
                                          ),
                                        ]))),
                                Flexible(flex: 1, child: Container()),
                                Flexible(
                                  flex: 4,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                            flex: 4,
                                            child: Container(
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                  color: Color(Get.find<
                                                          SimpleController>()
                                                      .ColorList[Get.find<
                                                          SimpleController>()
                                                      .line
                                                      .value]),
                                                  width: 5,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x3f000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "${info["statnNm"]}",
                                                style: TextStyle(fontSize: 15),
                                                textAlign: TextAlign.center,
                                              )),
                                            )),
                                        Flexible(
                                          flex: 5,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 30, bottom: 30),
                                            child: Image(
                                              image: AssetImage(
                                                  'downMovingArrow.gif'),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 6,
                                          child: CupertinoPicker(
                                              scrollController:
                                                  FixedExtentScrollController(
                                                      initialItem: 0),
                                              onSelectedItemChanged: (i) {
                                                setState(() {
                                                  controller.selectedStation =
                                                      stationList[i];
                                                  print(Get.find<
                                                          SimpleController>()
                                                      .selectedStation);
                                                  controller.update();
                                                });
                                              },
                                              itemExtent: 80,
                                              children: controller
                                                  .currentStationList),
                                        ),
                                      ]),
                                )
                              ],
                            )),
                      ),
                      Flexible(
                        child: Opacity(
                            opacity: 0.9,
                            child: Container(
                              margin: EdgeInsets.only(top: 70),
                              width: 393,
                              height: 93,
                              color: Color(Get.find<SimpleController>()
                                      .ColorList[
                                  Get.find<SimpleController>().scannedLine]),
                              child: MaterialButton(
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      "${controller.selectedStation}에서 하차",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 25),
                                    )),
                                onPressed: () {
                                  setState(() {
                                    controller.stationToGetOff =
                                        controller.selectedStation;
                                  });
                                  print("pressed");
                                },
                              ),
                            )),
                      )
                    ],
                  ),
                ],
              );
            } else {
              return const Center(child: Text("exception!"));
            }
          });
    });
  }
}
