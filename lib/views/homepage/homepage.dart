import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/color_palette.dart';
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
  late StreamSubscription<ConnectivityResult> connectionSubscription;
  @override
  void initState() {
    super.initState();
    subscribeToConnectionStatus();
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
    connectionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Media Query  And Material App Are Used Here For Testing Purposes
    return MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                    CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  ],
                );
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                key: const Key('PeopleListView'),
                controller: controller,
                itemCount: HomePageState.currentData.length + 1,
                itemBuilder: (context, index) {
                  if (index == HomePageState.currentData.length) {
                    if (!HomePageState.isConnected.value) {
                      return const SizedBox.shrink(
                        key: Key('LastElement'),
                      );
                    }
                    return const Center(
                      key: Key('LastElement'),
                      child: CircularProgressIndicator(color: kSecondaryColor),
                    );
                  }
                  return PersonCard(
                    person: HomePageState.currentData[index],
                    // key: Key(HomePageState.currentData[index].id.toString()),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  void subscribeToConnectionStatus() {
    //Listning To Changes On Connection Status
    connectionSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      log('Connection Status Changed');
      HomePageState.currentData.clear();
      PeopleController.getPeople();
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        HomePageState.isConnected.value = true;
        return;
      } else {
        HomePageState.isConnected.value = false;
      }
    });
    //Get Initial Data
    Connectivity().checkConnectivity().then((result) {
      if (result != ConnectivityResult.mobile &&
          result != ConnectivityResult.wifi) {
        PeopleController.getPeople();
      }
    });
  }
}
