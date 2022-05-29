import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'shared_prefs_handler.dart';
import '../models/person.dart';
import '../shared/endpoints.dart';
import '../shared/http_handler.dart';
import '../views/homepage/homepage_state.dart';

abstract class PeopleController {
  static int _currentPage = 1;
  static Future<void> getPeople() async {
    if (_currentPage == 501) return;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      _currentPage = 1;
      await SharedPrefsHandler.getPeople();
      return;
    }
    String url = ApiEndpoints.getPeopleEndPoint + _currentPage.toString();
    log("Called Get People On URL: $url");
    Response? response = await HttpHandler.getRequest(url);
    if (response == null) {
      return;
    }
    final result = response.data;
    for (var element in result['results']) {
      HomePageState.currentData.add(Person.fromJson(element));
    }
    if (_currentPage == 1) {
      SharedPrefsHandler.writePeople(jsonEncode(result['results']));
    }
    _currentPage++;
  }
}
