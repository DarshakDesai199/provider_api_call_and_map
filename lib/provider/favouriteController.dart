import 'package:flutter/cupertino.dart';

class FavouriteController extends ChangeNotifier {
  List selectedFav = [];

  void addRemoveFav(int index) {
    if (selectedFav.contains(index)) {
      selectedFav.remove(index);
    } else {
      selectedFav.add(index);
    }
    notifyListeners();
  }

  void removeFav(int index) {
    selectedFav.removeAt(index);
    notifyListeners();
  }
}
