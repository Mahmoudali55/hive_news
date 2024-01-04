import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorManger.white,
      ),
    );
  }
}
