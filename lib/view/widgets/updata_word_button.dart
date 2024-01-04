import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class UpdataWordButton extends StatelessWidget {
  const UpdataWordButton({super.key, required this.color, required this.ontap});
  final Color color;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 60,
        height: 35,
        decoration: getBoxDecoration(),
        child: Icon(Icons.add, color: ColorManger.black),
      ),
    );
  }

  BoxDecoration getBoxDecoration() =>
      BoxDecoration(borderRadius: BorderRadius.circular(10), color: color);
}
