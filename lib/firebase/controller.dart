import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireBaseController extends ChangeNotifier {
  QuerySnapshot<Map<String, dynamic>>? querySnapshot;
  DocumentSnapshot? documentSnapshot;
  List photoData = [];
  DocumentSnapshot? lastDocument;
  int limit = 3;
  bool isLoading = false;
  bool isMore = true;
  firebasePagination({bool isRefresh = false}) async {
    try {
      if (isMore) {
        isLoading = true;
        final data = FirebaseFirestore.instance.collection("Data");
        if (lastDocument == null || isRefresh) {
          photoData.clear();
          querySnapshot = await data.limit(limit).get();
        } else {
          querySnapshot =
              await data.limit(limit).startAfterDocument(lastDocument!).get();
        }
        lastDocument = querySnapshot!.docs.last;
        photoData.addAll(querySnapshot!.docs.map((e) => e.data()));
        isLoading = false;
        print('photoData == $photoData');
        print('photoData length== ${photoData.length}');
        if (querySnapshot!.docs.length < limit) {
          isMore = false;
          notifyListeners();
        }
        notifyListeners();
      } else {
        print('No Data Available');
      }
    } catch (e) {
      isLoading = false;
      print('error == $e');
    }
  }

  String searchValue = "";

  setSearchValue(value) {
    searchValue = value;
    notifyListeners();
  }
}
