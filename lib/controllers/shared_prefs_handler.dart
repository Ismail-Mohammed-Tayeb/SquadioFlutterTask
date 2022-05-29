import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/person.dart';
import '../views/homepage/homepage_state.dart';

abstract class SharedPrefsHandler {
  static Future<List<Person>?> getPeople() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('peopleList')) return null;
    String? res = prefs.getString('peopleList');
    if (res == null) {
      return null;
    }
    var data = jsonDecode(res);

    List<Person> allPeople = <Person>[];
    for (var element in data) {
      allPeople.add(Person.fromJson(element));
    }
    HomePageState.currentData.value = allPeople;
    return allPeople;
  }

  static Future<bool> writePeople(String people) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('peopleList', people);
      return true;
    } catch (e) {
      log('Error Occured While Storing Data To Hive');
      return false;
    }
  }
}
