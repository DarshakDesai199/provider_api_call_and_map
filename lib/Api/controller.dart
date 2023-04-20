import 'package:flutter/cupertino.dart';
import 'package:provider_demo/Api/model.dart';
import 'package:provider_demo/Api/repo.dart';

class ImageApiController extends ChangeNotifier {
  List<PhotoResponseModel>? photoResponseModel;
  bool isLoading = false;

  apiCall() async {
    isLoading = true;
    try {
      photoResponseModel = await ApiServices.photoRepo();
      isLoading = false;
    } catch (e) {
      isLoading = false;
      print('Image error === $e');
    }
    notifyListeners();
  }
}
