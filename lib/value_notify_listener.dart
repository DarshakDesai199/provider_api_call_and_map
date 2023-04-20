import 'package:flutter/material.dart';

class ValueNotifyScreen extends StatefulWidget {
  ValueNotifyScreen({Key? key}) : super(key: key);

  @override
  State<ValueNotifyScreen> createState() => _ValueNotifyScreenState();
}

class _ValueNotifyScreenState extends State<ValueNotifyScreen> {
  /// In this value notifier we can't need to create a provider controller.
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final ValueNotifier<bool> _obscure = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Value Notifier")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter.value++;
          print('${_counter.value}');
        },
        child: Icon(Icons.add),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ValueListenableBuilder(
          valueListenable: _counter,
          builder: (context, value, child) {
            return Center(
              child: Text(
                _counter.value.toString(),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: _obscure,
          builder: (context, value, child) {
            return Column(
              children: [
                TextFormField(
                  obscureText: _obscure.value,
                  decoration: InputDecoration(hintText: "Enter some value"),
                ),
                Switch(
                  value: _obscure.value,
                  onChanged: (value) {
                    _obscure.value = value;
                  },
                ),
              ],
            );
          },
        ),
      ]),
    );
  }
}
