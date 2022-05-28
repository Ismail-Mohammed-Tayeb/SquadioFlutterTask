import 'package:get/get.dart';
import 'package:squadio_flutter_task/models/person.dart';

abstract class HomePageState {
  static RxList<Person> currentData = <Person>[].obs;
}
