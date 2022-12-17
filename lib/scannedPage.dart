import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:subwaytracker/firebase_options.dart';
import 'package:swipe/swipe.dart';
import 'local_notification.dart';
import 'traindatacontroller.dart';
import 'navigationBar.dart';
import 'stationPicker.dart';
import 'informationPanel.dart';

class ScannedPage extends StatefulWidget {
  const ScannedPage({super.key});

  @override
  State<ScannedPage> createState() => _ScannedPageState();
}

class _ScannedPageState extends State<ScannedPage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('${Get.find<SimpleController>().scannedLine}')
      .snapshots();

  @override
  initState() {
    super.initState();
  }

  void _onAfterBuild(BuildContext context) {
    Get.find<SimpleController>().stationToGetOff = "none";
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SimpleController());
    return Scaffold(body: Center(child: GetBuilder<SimpleController>(
      builder: (controller) {
        return StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (controller.currentStationNm.string ==
                  controller.stationToGetOff) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _onAfterBuild(context));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              try {
                return snapshot.hasData
                    ? Swipe(
                        onSwipeRight: () {
                          Navigator.pop(context);
                        },
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
                                MyNavigationBar(
                                  //상단바
                                  line: "${controller.line.value}",
                                ),
                                InformationPanel(
                                    trainInfo: snapshot.data!.docs
                                        .where((e) =>
                                            e["trainNo"] ==
                                            Get.find<SimpleController>()
                                                .trainNo)
                                        .toList()[0]),
                                const SizedBox(
                                  //높이 여백(padding역할)
                                  width: double.infinity,
                                  height: 30,
                                ),
                                Flexible(child: StationPicker()),
                              ],
                            )))
                    : Center(
                        child: Text("null"),
                      );
              } catch (e) {
                return Center(
                  child: Text("exception!!"),
                );
              }
            });
      },
    )));
  }
}
