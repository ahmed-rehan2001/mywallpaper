import 'package:bubble_loader/bubble_loader.dart';
import 'package:flutter/material.dart';
import 'package:mywallpaper/extra/constants.dart';
class BubbleLoad extends StatelessWidget {
  const BubbleLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: BubbleLoader(
        color1: black,
        color2: grey,
        bubbleGap: 10,
        bubbleScalingFactor: 1,
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
}