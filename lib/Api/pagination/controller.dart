import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider_demo/Api/model.dart';

class PaginationController extends ChangeNotifier {
  int pageCount = 1;
  List<PhotoResponseModel> photoData = [];
  bool isMore = true;
  bool isLoading = false;
  Future apiRepo({bool isRefresh = false}) async {
    if (isMore) {
      if (isRefresh) {
        print('Enter ====================');
        pageCount = 1;
        notifyListeners();
        print('isRefresh==================');
      }
      isLoading = true;
      var headerData = {
        "Authorization": "Client-ID R-m3InIjdEFVYrxuhRDCX9eTbmjezkkmhJcRbHhfVV4"
      };
      try {
        http.Response response = await http.get(
            Uri.parse(
                "https://api.unsplash.com/photos?page=$pageCount&per_page=8"),
            headers: headerData);

        if (response.statusCode == 200) {
          print('Api call ');
          List<PhotoResponseModel> photoResponseModel =
              photoResponseModelFromJson(response.body);
          isLoading = false;
          if (isRefresh) {
            print('Enter in refresh');
            photoData.clear();
            photoData = photoResponseModel;
          } else {
            photoData.addAll(photoResponseModel);
          }
          pageCount++;
          print('pagecount === $pageCount');
          print('pagecount length=== ${photoResponseModel.length}');

          if (pageCount > photoResponseModel.length) {
            print('End============');
            isMore = false;
            isLoading = false;
            notifyListeners();
          }
        } else {
          isLoading = false;
        }
        notifyListeners();
      } catch (e) {
        isLoading = false;
        notifyListeners();

        print('pagination == $e');
      }
    } else {}
  }
}
