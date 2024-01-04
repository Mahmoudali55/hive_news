import 'package:flutter/widgets.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget(
      {super.key, required this.iconData, required this.message});
  final IconData iconData;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        iconData,
        color: ColorManger.white,
        size: 100,
      ),
      Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ColorManger.white,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      )
    ]);
  }
}
