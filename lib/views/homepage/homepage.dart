import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  @override
  void initState() {
    super.initState();
    //Get Initial Data
    PeopleController.getPeople();
    //ListView Listner To Later Populate and Append New Data
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        //Reached End Of The List, Next Paged Data Must Be Loaded
        PeopleController.getPeople();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
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
