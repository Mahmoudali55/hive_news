import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class WordInfoWidget extends StatelessWidget {
  const WordInfoWidget(
      {super.key,
      required this.color,
      required this.text,
      required this.isArabic,
      this.onpressed});
  final Color color;
  final String text;
  final bool isArabic;
  final VoidCallback? onpressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: getBoxDecoration(),
      child: Row(children: [
        getArabicWidget(),
        const SizedBox(width: 10),
        Expanded(child: getTextWidget()),
        if (onpressed != null)
          IconButton(onPressed: onpressed, icon: Icon(Icons.delete))
      ]),
    );
  }

  Text getTextWidget() {
    return Text(
      text,
      style: TextStyle(
        color: ColorManger.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  CircleAvatar getArabicWidget() {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorManger.black,
      child: Text(
        isArabic ? 'ar' : 'en',
        style: TextStyle(color: color),
      ),
    );
  }

  BoxDecoration getBoxDecoration() => BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      );
}
