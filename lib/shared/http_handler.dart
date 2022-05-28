import 'dart:developer';

import 'package:dio/dio.dart';

abstract class HttpHandler {
  static Future<Response?> getRequest(String url) async {
    try {
      Response response = await Dio().get(url);
      if (response.statusCode == 200) {
        return response;
      }
      return null;
    } catch (e) {
      log("An Exception Occured With A Get Request: ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> downloadRequest(String url) async {
    return null;
  }
}
