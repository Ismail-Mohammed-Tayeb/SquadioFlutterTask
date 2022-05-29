import 'package:get/get.dart';

import '../../models/person.dart';

abstract class HomePageState {
  static RxList<Person> currentData = <Person>[].obs;
  static RxBool isConnected = false.obs;
}
