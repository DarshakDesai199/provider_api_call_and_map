import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/provider/sliderController.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: Consumer<SliderController>(
        builder: (context, value, child) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Slider(
              value: value.sliderValue,
              min: 0,
              max: 1,
              onChanged: (val) {
                value.setSliderValue(val);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    color: Colors.red.withOpacity(value.sliderValue),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    color: Colors.green.withOpacity(value.sliderValue),
                  ),
                )
              ],
            )
          ]);
        },
      ),
    );
  }
}
