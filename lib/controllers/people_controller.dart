import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:squadio_flutter_task/models/person.dart';
import 'package:squadio_flutter_task/shared/endpoints.dart';
import 'package:squadio_flutter_task/shared/http_handler.dart';
import 'package:squadio_flutter_task/views/homepage/homepage_state.dart';

abstract class PeopleController {
  static int _currentPage = 1;
  //https://api.themoviedb.org/3/person/popular?api_key=8f907a9fcbdd2843e00e8dafbb58fd60&language=en-US&page=9
  static Future<void> getPeople() async {
    String url = ApiEndpoints.getPeopleEndPoint + _currentPage.toString();
    log("Called Get People On URL: $url");
    Response? response = await HttpHandler.getRequest(url);
    _currentPage++;
    if (response == null) {
      return;
    }
    final result = response.data;
    for (var element in result['results']) {
      HomePageState.currentData.add(Person.fromJson(element));
    }
  }
}
