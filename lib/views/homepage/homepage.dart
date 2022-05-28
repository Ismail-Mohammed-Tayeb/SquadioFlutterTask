import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squadio_flutter_task/controllers/people_controller.dart';
import 'package:squadio_flutter_task/views/homepage/homepage_state.dart';

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
    //ListView Listner To Later Update Data Among
    PeopleController.getPeople();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        //Reached End Of The List, Next Paged Data Must Be Loaded
        PeopleController.getPeople();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: .0,
        title: const Text('Popular People'),
        actions: [ElevatedButton(onPressed: () {}, child: const Text("+"))],
      ),
      body: SizedBox.expand(
        child: Obx(() {
          if (HomePageState.currentData.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                Text('Loading People Data'),
              ],
            );
          }
          return ListView.builder(
            controller: controller,
            itemCount: HomePageState.currentData.length + 1,
            itemBuilder: (context, index) {
              if (index == HomePageState.currentData.length) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListTile(
                title: Text(
                  HomePageState.currentData[index].name,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
