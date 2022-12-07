import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:subwaytracker/mainpage.dart';
import 'package:subwaytracker/scannedPage.dart';

class SimpleController extends GetxController {
  Map idToStation = {"line5": "5호선", "dxline": "신분당선", "slline": "신림선"};
  String selectedStation = "..";
  RxString line = "SubwayTracker".obs;
  List<Widget> currentStationList = [];
  String scannedLine = "SubwayTracker";
  late String trainNo;
  String currentStationNm = "loading...";
  late List pickerStationList;
  bool arrived = false;
  var trainData;
  String stationToGetOff = "none";

  Map ColorList = {
    "SubwayTracker": 0xffd3d3d3,
    "5호선": 0xff996cac,
    "신분당선": 0xffD4003B,
    "신림선": 0xff6789CA
  };
  Map LineInfo = {
    "신분당선": {
      "stationNm": [
        "...",
        "신사",
        "논현",
        "신논현",
        "강남",
        "양재",
        "양재시민의숲",
        "청계산입구",
        "판교",
        "정자",
        "미금",
        "동천",
        "수지구청",
        "성복",
        "상현",
        "광교중앙",
        '광교',
        "..."
      ],
    },
    "SubwayTracker": {
      "stationNm": ["no", "Station"],
      "stationCd": ["noStation"]
    }
  };

  final regions = <Region>[
    for (var train in [for (var i = 1; i <= 10; i++) i])
      Region(
          identifier: "dxline",
          proximityUUID: '74278bda-b644-4520-8f0c-720eaf059935',
          major: train,
          minor: 19641)
  ];

  void StringListToWidgetList(List<String> stationString) {
    currentStationList = [...stationString.map((e) => StringToWidget(e))];
  }

  void updateLine(value) {
    line(value);
    update();
  }

  @override
  void onInit() {
    ever(line, ((callback) {
      StringListToWidgetList(
          LineInfo[line.value]["stationNm"]); //pageView 도입 시 삭제될 예정
      update();
    }));
  }

  List<String> slicingStatonList() {
    if (trainData["statnTnm"] == "신사") {
      final reversedlist =
          List<String>.from(LineInfo[line.value]["stationNm"].reversed);
      final stationList = reversedlist.sublist(
          reversedlist.indexOf(trainData["statnNm"]) + 1,
          reversedlist.indexOf(trainData["statnTnm"]) + 1);
      return stationList;
    } else {
      final stationList = LineInfo[line.value]["stationNm"].sublist(
          LineInfo[line.value]["stationNm"].indexOf(trainData["statnNm"]) + 1,
          LineInfo[line.value]["stationNm"].indexOf(trainData["statnTnm"]) + 1);
      return stationList;
    }
  }

  Future<void> initBeacoon() async {
    await flutterBeacon.initializeScanning;
    // or if you want to include automatic checking permission
    await flutterBeacon.initializeAndCheckScanning;
  }

  Future<void> scanBeacon() async {
    var streamRanging;
    // if you want to manage manual checking about the required permissions
    // to start monitoring beacons
    streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      // result contains a region, event type and event state
      print(result.beacons);
      if (result.beacons.length > 0) {
        //scan되었을 때
        if (arrived) {
          scannedLine = "SubwayTracker";
          arrived = false;
          Get.back();
        } else {
          print(result.region.identifier);
          trainNo = result.region.major.toString();
          final currentline = idToStation[result.region.identifier.toString()];

          final db = FirebaseFirestore.instance;
          final docRef = db.collection("${currentline}").doc("${trainNo}");
          docRef.get().then(
            (DocumentSnapshot doc) {
              trainData = doc.data() as Map<String, dynamic>;
              currentStationNm = trainData["statnNm"];
              if (trainData["statnTnm"] == currentStationNm) {
                Get.back();
                scannedLine = "SubwayTracker";
              } else {
                scannedLine = currentline;
              }
            },
            onError: (e) {
              scannedLine = "SubwayTracker";
              print("Error getting document: $e");
            },
          );
        }

        updateLine(scannedLine);
        update();
      } else {
        //이외의 경우
        scannedLine = "SubwayTracker";
        Get.back();
        updateLine("SubwayTracker");
      }
    }); // to stop monitoring beacons
  }

  Widget StringToWidget(String station) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Color(ColorList[line.value]),
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
        "$station",
        style: TextStyle(fontSize: 15),
      )),
    );
  }
}
