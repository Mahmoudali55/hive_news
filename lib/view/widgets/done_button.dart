import 'package:flutter/material.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key, required this.colorCode, required this.ontap});
  final int colorCode;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 50,
          width: 70,
          decoration: BoxDecoration(
              color: ColorManger.white,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text('Done',
                style: TextStyle(
                    color: Color(colorCode),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
