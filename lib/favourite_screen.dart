import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/provider/favouriteController.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavListScreen(),
                    ));
              },
              icon: Icon(Icons.add))),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Consumer<FavouriteController>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('$index items'),
                    IconButton(
                      onPressed: () {
                        value.addRemoveFav(index);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: value.selectedFav.contains(index)
                            ? Colors.red
                            : Colors.grey,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FavListScreen extends StatefulWidget {
  const FavListScreen({Key? key}) : super(key: key);

  @override
  State<FavListScreen> createState() => _FavListScreenState();
}

class _FavListScreenState extends State<FavListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavouriteController>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.selectedFav.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('${value.selectedFav[index]} items'),
                    IconButton(
                      onPressed: () {
                        print('remove index == $index');
                        value.removeFav(index);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
