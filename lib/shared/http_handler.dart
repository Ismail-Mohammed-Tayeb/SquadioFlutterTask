import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

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

  Future<bool> downloadRequest(String url) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: url.split('/').last);
    return result['isSuccess'].toString() == 'true';
  }
}
