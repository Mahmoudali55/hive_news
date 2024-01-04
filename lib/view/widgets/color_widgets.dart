import 'package:flutter/material.dart';
import 'package:hive_news/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_news/view/styles/color_manger.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.activeColor});
  final int activeColor;
  final List<int> colorcode = const [
    0xFF4A47A3,
    0xFF0C7B93,
    0xFFB92CDC,
    0xFFB92C93,
    0xFFBC6FF1,
    0xFFFA8072,
    0xFF4D4C7D,
    0xFF8FBC8F,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => getItemDesign(index, context),
          separatorBuilder: (context, index) => const SizedBox(
                width: 7,
              ),
          itemCount: colorcode.length),
    );
  }

  Widget getItemDesign(int index, BuildContext context) {
    return InkWell(
      onTap: () =>
          WriteDataCubit.get(context).updateColorCode(colorcode[index]),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Color(colorcode[index]),
            border: activeColor == colorcode[index]
                ? Border.all(color: ColorManger.white, width: 2)
                : null,
            shape: BoxShape.circle),
        child: activeColor == colorcode[index]
            ? const Center(
                child: Icon(
                  Icons.done,
                  color: ColorManger.white,
                ),
              )
            : null,
      ),
    );
  }
}
