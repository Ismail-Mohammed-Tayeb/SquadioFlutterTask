import 'package:dio/dio.dart';
import '../models/person_details.dart';
import '../shared/http_handler.dart';

import '../shared/endpoints.dart';

abstract class PersonController {
  static Future<PersonDetails?> getPeronDetails(int personId) async {
    String url = ApiEndpoints.getPersonDetailsEndPoint +
        personId.toString() +
        ApiEndpoints.apiKey;
    Response? response = await HttpHandler.getRequest(url);
    if (response == null) {
      return null;
    }
    return PersonDetails.fromJson(response.data);
  }

  static Future<List<String>> getPersonImages(int personId) async {
    String url =
        'https://api.themoviedb.org/3/person/$personId/images${ApiEndpoints.apiKey}';
    Response? response = await HttpHandler.getRequest(url);
    if (response == null) {
      return [];
    }
    List<String> images = <String>[];
    for (var element in response.data["profiles"]) {
      images.add(ApiEndpoints.imageEndpoint + element["file_path"].toString());
    }
    return images;
  }
}
