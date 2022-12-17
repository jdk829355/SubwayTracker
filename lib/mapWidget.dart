import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'local_notification.dart';
import 'traindatacontroller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScrollMapWidget extends StatefulWidget {
  const ScrollMapWidget({super.key});

  @override
  State<ScrollMapWidget> createState() => _ScrollMapWidgetState();

  static void goToTheCurrentStation() {}
}

class _ScrollMapWidgetState extends State<ScrollMapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(
          Get.find<SimpleController>().stationPosition[
              Get.find<SimpleController>()
                  .currentStationNm
                  .string]!["stationLat"] as double,
          Get.find<SimpleController>().stationPosition[
              Get.find<SimpleController>()
                  .currentStationNm
                  .string]!["stationLng"] as double),
      zoom: 16);

  @override
  Widget build(BuildContext context) {
    Get.put(SimpleController());
    WidgetsBinding.instance.addPostFrameCallback((_) => _onAfterBuild(context));

    final db = FirebaseFirestore.instance;
    if (Get.find<SimpleController>().trainNo != null) {
      final docRef = db
          .collection(Get.find<SimpleController>().scannedLine)
          .doc(Get.find<SimpleController>().trainNo);
      docRef.get().then((DocumentSnapshot doc) {});
    }

    if (Get.find<SimpleController>().scannedLine == "SubwayTracker" ||
        Get.find<SimpleController>().trainNo == null) {
      return Container(
          width: 353,
          height: 440,
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
            onPressed: (() {
              Get.find<SimpleController>().arrived = false;
            }),
            child: Center(
                child: Text(
              Get.find<SimpleController>().arrived == true
                  ? "터치하여 다시 스캔"
                  : "열차에 탑승하지 않았어요 😢",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )),
          ));
    } else {
      return Obx((() {
        return Container(
            width: 353,
            height: 440,
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
            child: GoogleMap(
              myLocationButtonEnabled: false,
              scrollGesturesEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              trafficEnabled: true,
              myLocationEnabled: false,
              mapType: MapType.terrain,
              initialCameraPosition: returnCurrentPosition(
                  Get.find<SimpleController>().currentStationNm.value),
              onMapCreated: (GoogleMapController controller) {
                if (Get.find<SimpleController>().counter == 0) {
                  Get.find<SimpleController>().counter = 1;
                  _controller.complete(controller);
                }
              },
            ));
      }));
    }
  }

  void _onAfterBuild(BuildContext context) {
    goToTheCurrentStation();
  }

  CameraPosition returnCurrentPosition(stationNm) {
    return CameraPosition(
        target: LatLng(
            Get.find<SimpleController>().stationPosition[stationNm] == null
                ? 0.0
                : Get.find<SimpleController>()
                    .stationPosition[stationNm]!["stationLat"] as double,
            Get.find<SimpleController>().stationPosition[stationNm] == null
                ? 0.0
                : Get.find<SimpleController>()
                    .stationPosition[stationNm]!["stationLng"] as double),
        zoom: 16);
  }

  Future<void> goToTheCurrentStation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      returnCurrentPosition(
          Get.find<SimpleController>().currentStationNm.value),
    ));
  }
}
