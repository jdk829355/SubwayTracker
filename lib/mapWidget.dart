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
                  Get.find<SimpleController>().currentStationNm]!["stationLat"]
              as double,
          Get.find<SimpleController>().stationPosition[
                  Get.find<SimpleController>().currentStationNm]!["stationLng"]
              as double),
      zoom: 17);

  @override
  Widget build(BuildContext context) {
    Get.put(SimpleController());
    if (Get.find<SimpleController>().currentStationNm ==
        Get.find<SimpleController>().stationToGetOff) {
      Get.back();
      LocalNotification()
          .sampleNotification(Get.find<SimpleController>().stationToGetOff);
      Get.find<SimpleController>().arrived = true;
      Get.find<SimpleController>().stationToGetOff = "none";
    }

    if (Get.find<SimpleController>().scannedLine == "SubwayTracker") {
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
        child: const Center(
            child: Text(
          "열차에 탑승하지 않았어요 😢",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        )),
      );
    } else {
      final db = FirebaseFirestore.instance;
      final docRef = db
          .collection("${Get.find<SimpleController>().scannedLine}")
          .doc("${Get.find<SimpleController>().trainNo}");

      docRef.get().then((DocumentSnapshot doc) {
        final CameraPosition _kGooglePlex = CameraPosition(
            target: LatLng(
                Get.find<SimpleController>().stationPosition[
                    Get.find<SimpleController>()
                        .currentStationNm]!["stationLat"] as double,
                Get.find<SimpleController>().stationPosition[
                    Get.find<SimpleController>()
                        .currentStationNm]!["stationLng"] as double),
            zoom: 17);
        goToTheCurrentStation();
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
            mapType: MapType.terrain,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    Get.find<SimpleController>().stationPosition[
                        Get.find<SimpleController>()
                            .currentStationNm]!["stationLat"] as double,
                    Get.find<SimpleController>().stationPosition[
                        Get.find<SimpleController>()
                            .currentStationNm]!["stationLng"] as double),
                zoom: 18),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        );
      });

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
          mapType: MapType.terrain,
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  Get.find<SimpleController>().stationPosition[
                      Get.find<SimpleController>()
                          .currentStationNm]!["stationLat"] as double,
                  Get.find<SimpleController>().stationPosition[
                      Get.find<SimpleController>()
                          .currentStationNm]!["stationLng"] as double),
              zoom: 17),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      );
    }
  }

  Future<void> goToTheCurrentStation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(
              Get.find<SimpleController>().stationPosition[
                  Get.find<SimpleController>()
                      .currentStationNm]!["stationLat"] as double,
              Get.find<SimpleController>().stationPosition[
                  Get.find<SimpleController>()
                      .currentStationNm]!["stationLng"] as double),
          zoom: 17),
    ));
  }
}
