import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 35,
        child: LoadingAnimationWidget.threeRotatingDots(
            color: Colors.blue, size: 35),
      ),
    );
  }
}
