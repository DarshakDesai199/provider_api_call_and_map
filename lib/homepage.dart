import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/provider/countController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final counterProvider =
        Provider.of<CounterController>(context, listen: false);

    /// when we use listen true then build called .
    print('build called');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.setCount();
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<CounterController>(
        builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  counterProvider.count.toString(),
                  style: TextStyle(fontSize: 35),
                ),
              ),
              Center(
                child: Text(
                  counterProvider.sample.toString(),
                  style: TextStyle(fontSize: 35),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    value.sample = 5000;
                  },
                  child: Text('Add'))
            ],
          );
        },
      ),
    );
  }
}
