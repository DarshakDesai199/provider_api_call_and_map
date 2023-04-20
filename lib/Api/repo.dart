import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_demo/Api/model.dart';

class ApiServices {
  static Future<List<PhotoResponseModel>?> photoRepo() async {
    var headerData = {
      "Authorization": "Client-ID R-m3InIjdEFVYrxuhRDCX9eTbmjezkkmhJcRbHhfVV4"
    };
    http.Response response = await http
        .get(Uri.parse("https://api.unsplash.com/photos"), headers: headerData);

    if (response.statusCode == 200) {
      print('jsonDecode === ${jsonDecode(response.body)}');
      List<PhotoResponseModel> photoResponseModel =
          photoResponseModelFromJson(response.body);
      print('photoResponseModel==$photoResponseModel');
      return photoResponseModel;
    } else {
      return null;
    }
  }
}
