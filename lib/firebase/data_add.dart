import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider_demo/Api/model.dart';
import 'package:provider_demo/firebase/controller.dart';
import 'package:shimmer/shimmer.dart';

class DataAdd extends StatefulWidget {
  const DataAdd({Key? key}) : super(key: key);

  @override
  State<DataAdd> createState() => _DataAddState();
}

class _DataAddState extends State<DataAdd> {
  apiCall() async {
    Map<String, String> headerData = {
      "Authorization": "Client-ID R-m3InIjdEFVYrxuhRDCX9eTbmjezkkmhJcRbHhfVV4"
    };
    try {
      http.Response response = await http.get(
          Uri.parse("https://api.unsplash.com/photos?page=1&per_page=20"),
          headers: headerData);

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        print('Data === $data');
        data.forEach((element) async {
          await FirebaseFirestore.instance.collection('Data').add(element);
        });
      }
    } catch (e) {
      print('API CALL ERROR === $e');
    }
  }

  @override
  void initState() {
    var firebaseController =
        Provider.of<FireBaseController>(context, listen: false);
    firebaseController.firebasePagination();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        firebaseController.firebasePagination();
      }
    });
    super.initState();
  }

  ScrollController scrollController = ScrollController();
  Color whiteCommon = Colors.white;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<FireBaseController>(
        builder: (context, value, child) {
          print('asdfg');
          return SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 70,
                  width: double.infinity,
                  // color: Colors.red,
                  child: TextFormField(
                    controller: textEditingController,
                    style: TextStyle(color: Colors.black),
                    onChanged: (val) {
                      value.setSearchValue(val);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return value.firebasePagination(isRefresh: true);
                    },
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: value.photoData.length,
                      itemBuilder: (context, index) {
                        var data = value.photoData[index];
                        var colorData =
                            data['color'].toString().split('#').last;
                        var color = int.parse("0xff$colorData");
                        // print('$color');
                        return data['user']['first_name']
                                .toString()
                                .toLowerCase()
                                .contains(value.searchValue.toLowerCase())
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  // color: Colors.grey.shade900,
                                  color: Color(color),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 300,
                                        width: 170,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${data['urls']['regular']}",
                                          fit: BoxFit.fill,
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) {
                                            return Center(
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.white
                                                    .withOpacity(0.4),
                                                highlightColor: Colors.white
                                                    .withOpacity(0.2),
                                                enabled: true,
                                                child: Container(
                                                  height: 300,
                                                  width: 170,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                          errorWidget: (context, url, error) =>
                                              Center(child: Icon(Icons.error)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 300,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "${data['user']['profile_image']['large']}",
                                                  fit: BoxFit.fill,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                          downloadProgress) {
                                                    return Center(
                                                      child: Shimmer.fromColors(
                                                        baseColor: Colors.white
                                                            .withOpacity(0.4),
                                                        highlightColor: Colors
                                                            .white
                                                            .withOpacity(0.2),
                                                        enabled: true,
                                                        child: Container(
                                                          height: 80,
                                                          width: 80,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Center(
                                                              child: Icon(
                                                                  Icons.error)),
                                                ),
                                              ),
                                              Text(
                                                "${data['alt_description']}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "Name : ${data['user']['first_name']} ${data['user']['last_name']}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              data['user']['instagram_username'] ==
                                                          null ||
                                                      data['user'][
                                                              'instagram_username'] ==
                                                          ""
                                                  ? SizedBox()
                                                  : Text(
                                                      "Insta id : ${data['user']['instagram_username']}",
                                                      style: TextStyle(
                                                        color: Colors.white70,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                              Text(
                                                "Location : ${data['user']['location']}",
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 28.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 7,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.favorite,
                                                              color: Colors.red,
                                                              size: 18),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            "${data['user']['total_likes']}",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox();
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: value.isLoading,
                  child: Center(child: CircularProgressIndicator()),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> buildStreamBuilder() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Data').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('length=== ${snapshot.data!.docs.length}');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey.shade900,
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl:
                                "${snapshot.data!.docs[index]['urls']['regular']}",
                            fit: BoxFit.fill,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) {
                              return Center(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.white.withOpacity(0.4),
                                  highlightColor: Colors.white.withOpacity(0.2),
                                  enabled: true,
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
