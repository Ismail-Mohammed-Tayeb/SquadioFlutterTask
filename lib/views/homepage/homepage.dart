import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squadio_flutter_task/controllers/shared_prefs_handler.dart';
import 'package:squadio_flutter_task/shared/color_palette.dart';
import '../../controllers/people_controller.dart';
import 'homepage_state.dart';
import 'widgets/person_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
    //Listning To Changes On Connection Status
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      log('Connection Status Changed');
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        //Then There is an internet connection
        log('Connected');
        HomePageState.isConnected.value = true;
        HomePageState.currentData.clear();
        PeopleController.getPeople();
        return;
      }
      HomePageState.isConnected.value = false;

      log('No Connection');
      HomePageState.currentData.clear();
      SharedPrefsHandler.getPeople();
    });
    //Get Initial Data
    Connectivity().checkConnectivity().then((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        //Then There is an internet connection
        HomePageState.isConnected.value = true;

        log('Connected');
        HomePageState.currentData.clear();
        PeopleController.getPeople();
        return;
      }
      HomePageState.isConnected.value = false;

      log('No Connection');
      HomePageState.currentData.clear();
      SharedPrefsHandler.getPeople();
    });
    //ListView Listner To Later Populate and Append New Data
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        //Reached End Of The List, Next Paged Data Must Be Loaded
        Connectivity().checkConnectivity().then((result) {
          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi) {
            PeopleController.getPeople();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: .0,
        title: const Text('Popular People'),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Obx(() {
          if (HomePageState.currentData.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(color: kSecondaryColor),
              ],
            );
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            itemCount: HomePageState.currentData.length + 1,
            itemBuilder: (context, index) {
              if (index == HomePageState.currentData.length) {
                if (!HomePageState.isConnected.value) {
                  return const SizedBox.shrink();
                }
                return const Center(
                    child: CircularProgressIndicator(color: kSecondaryColor));
              }
              return PersonCard(person: HomePageState.currentData[index]);
            },
          );
        }),
      ),
    );
  }
}
