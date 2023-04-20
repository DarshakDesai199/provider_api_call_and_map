import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'controller.dart';

class PaginationImage extends StatefulWidget {
  const PaginationImage({Key? key}) : super(key: key);

  @override
  State<PaginationImage> createState() => _PaginationImageState();
}

class _PaginationImageState extends State<PaginationImage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    var paginationProvider =
        Provider.of<PaginationController>(context, listen: false);
    paginationProvider.apiRepo();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        paginationProvider.apiRepo();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<PaginationController>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              edgeOffset: 20,
              color: Colors.white,
              backgroundColor: Colors.grey,
              onRefresh: () {
                return value.apiRepo(isRefresh: true);
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: value.photoData.length,
                      itemBuilder: (context, index) {
                        var data = value.photoData[index];
                        return Card(
                          color: Colors.grey,
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                  imageUrl: "${data.urls!.regular}",
                                  fit: BoxFit.fill,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.white.withOpacity(0.4),
                                      highlightColor:
                                          Colors.white.withOpacity(0.2),
                                      enabled: true,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                      visible: value.isLoading,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.red,
                      ))),
                  Visibility(
                    visible: !value.isMore,
                    replacement: SizedBox(),
                    child: Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
